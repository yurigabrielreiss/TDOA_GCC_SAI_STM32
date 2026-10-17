"""Coleta de telemetria do array: ambiente/distancia/angulo/repNNN_*.

Instalar: py -m pip install pyserial
Executar: py coletar_array.py
Ao executar, informe o angulo e o numero de repeticoes no terminal.
Depois de cada sequencia, escolha outro angulo ou digite q para sair.
O comando anterior, com 'coletar' e argumentos, continua funcionando.
"""

import argparse
import csv
import math
import re
import time
import wave
from datetime import datetime, timedelta
from pathlib import Path
from statistics import mean


# ================= ALTERE AS CONFIGURACOES AQUI =================
PASTA_BASE = Path(__file__).resolve().parent  # Onde criar Estudio/Sala de aula.
AMBIENTE = "Sala"                       # Outra opcao: "Sala de aula".
DISTANCIA_M = 1                         # 0.5, 1.0 ou 2.0 metros.
# Angulo e repeticoes sao escolhidos no terminal, a cada sequencia.
PORTA = "COM9"
BAUD = 115200
DURACAO_S = 10.0
ARQUIVO_WAV = None  # None = reproducao externa.
# ==============================================================

COLUNAS = [
    "data_hora", "repeticao", "tempo_s", "angulo_real_deg",
    "angulo_estimado_deg", "TDOA12_amostras", "TDOA13_amostras",
    "TDOA23_amostras", "estimativa", "erro_angular_deg", "Ec_amostras",
    "pico12", "pico13", "pico23", "motivo",
]


def pasta_condicao(base, ambiente, distancia, angulo):
    """ALTERE AQUI se quiser mudar os nomes/ordem das pastas."""
    medida = format(distancia, ".12g").replace(".", ",")
    unidade = "metro" if distancia == 1 else "metros"
    nome_angulo = format(angulo, ".12g").replace(".", ",")
    return Path(base) / ambiente / f"{medida}{unidade}" / f"angulo{nome_angulo}"


def validar_angulo(texto):
    """Aceita graus decimais com ponto ou virgula, sem lista predefinida."""
    try:
        angulo = float(texto.strip().replace(",", "."))
    except ValueError as exc:
        raise ValueError("Informe um angulo numerico, como 0, 37 ou 22,5.") from exc
    if not math.isfinite(angulo) or not 0 <= angulo < 360:
        raise ValueError("O angulo deve ser maior ou igual a 0 e menor que 360.")
    return angulo


def solicitar_repeticoes(angulo):
    while True:
        texto = input(f"Quantas repeticoes para {angulo:g} graus? (q encerra): ").strip()
        if texto.lower() == "q":
            return None
        try:
            repeticoes = int(texto)
            if repeticoes >= 1:
                return repeticoes
        except ValueError:
            pass
        print("Informe um numero inteiro positivo, como 1, 5 ou 10.")


def escolher_sequencias(angulos=None, repeticoes=None):
    """Sem argumentos, permite escolher sucessivos angulos manualmente."""
    if angulos is not None:
        for angulo in angulos:
            quantidade = repeticoes if repeticoes is not None else solicitar_repeticoes(angulo)
            if quantidade is None:
                return
            yield angulo, quantidade
        return
    while True:
        texto = input("\nQual angulo deseja medir? (0 a <360 graus; q encerra): ").strip()
        if texto.lower() == "q":
            return
        try:
            angulo = validar_angulo(texto)
        except ValueError as exc:
            print(exc)
            continue
        quantidade = repeticoes if repeticoes is not None else solicitar_repeticoes(angulo)
        if quantidade is None:
            return
        yield angulo, quantidade


def numero(texto):
    try:
        valor = float(texto)
        return valor if math.isfinite(valor) else None
    except (TypeError, ValueError):
        return None


def tripla(campos, chave, escala=1):
    partes = campos.get(chave, "").split(",")
    if len(partes) != 3:
        return [None] * 3
    return [None if numero(v) is None else numero(v) / escala for v in partes]


def analisar_linha(texto, tempo, inicio, repeticao, real):
    if not texto.startswith("ANGLE:"):
        return None  # Mensagens auxiliares continuam no arquivo serial.txt.
    campos = dict(re.findall(r"([A-Z][A-Z0-9_]*):(\S+)", texto))
    angulo_texto = campos.get("ANGLE", "")
    estimado = numero(angulo_texto)
    if angulo_texto == "INVALID":
        estado = "rejeitada"
    elif estimado is not None and 0 <= estimado < 360:
        estado = "valida"
    else:
        estimado, estado = None, "nao_interpretada"

    t12, t13, t23 = tripla(campos, "TAU1000", 1000)
    picos = tripla(campos, "PEAK")
    if "PEAK1000000" in campos:
        picos = tripla(campos, "PEAK1000000", 1_000_000)
    erro = (estimado - real + 180) % 360 - 180 if estado == "valida" else None
    ec = abs(t13 - t12 - t23) if None not in (t12, t13, t23) else None
    return dict(zip(COLUNAS, [
        (inicio + timedelta(seconds=tempo)).isoformat(timespec="milliseconds"),
        repeticao, round(tempo, 6), real, estimado, t12, t13, t23,
        estado, erro, ec, *picos,
        campos.get("REASON", "OK" if estado == "valida" else "nao_informado"),
    ]))


def proxima_repeticao(pasta):
    numeros = []
    for arquivo in pasta.glob("rep*_*.*"):
        achado = re.match(r"rep(\d+)_", arquivo.name)
        if achado:
            numeros.append(int(achado[1]))
    return max(numeros, default=0) + 1


def capturar(ser, destino, duracao, wav, tocar=None):
    """Grava os bytes primeiro. So interpreta as linhas depois da captura.

    Os tempos sao de recepcao no PC; nao sao tempos das amostras de audio.
    A primeira/ultima linha incompleta fica no TXT, mas nao entra no CSV.
    """
    recebidos = []
    status, detalhe = "concluida", ""
    iniciou_audio = False
    with destino.open("xb") as arquivo:  # Nunca sobrescreve outra coleta.
        inicio = datetime.now().astimezone()
        t0 = time.perf_counter()
        try:
            ser.reset_input_buffer()
            inicio = datetime.now().astimezone()
            t0 = time.perf_counter()
            if wav:
                iniciou_audio = True
                tocar(str(wav))
            while True:
                restante = duracao - (time.perf_counter() - t0)
                if restante <= 0:
                    break
                ser.timeout = min(0.02, restante)
                bloco = ser.read(min(4096, max(1, ser.in_waiting)))
                tempo = time.perf_counter() - t0
                if bloco:
                    arquivo.write(bloco)
                    arquivo.flush()
                    recebidos.append((tempo, bloco))
        except KeyboardInterrupt:
            status = "interrompida"
        except Exception as exc:
            status, detalhe = "erro", str(exc)
        finally:
            observado = time.perf_counter() - t0
            if iniciou_audio:
                try:
                    tocar(None)
                except Exception as exc:
                    status, detalhe = "erro", str(exc)
    return inicio, recebidos, status, detalhe, observado


def converter(recebidos, inicio, repeticao, real, duracao):
    linhas, pendente = [], b""
    for tempo, bloco in recebidos:
        pendente += bloco
        while b"\n" in pendente:
            linha, pendente = pendente.split(b"\n", 1)
            if tempo > duracao:
                continue  # Ultima leitura pode terminar ligeiramente apos o limite.
            texto = linha.rstrip(b"\r").decode("utf-8", errors="replace")
            r = analisar_linha(texto, tempo, inicio, repeticao, real)
            if r is not None:
                linhas.append(r)
    return linhas


def escrever_csv(destino, linhas, campos, anexar=False):
    existe = destino.exists() and destino.stat().st_size > 0
    with destino.open("a" if anexar else "x", newline="", encoding="utf-8-sig") as f:
        writer = csv.DictWriter(f, fieldnames=campos, delimiter=";")
        if not anexar or not existe:
            writer.writeheader()
        writer.writerows(linhas)


def resumir(linhas, inicio, rep, ambiente, distancia, real, status, observado, detalhe):
    validos = [r for r in linhas if r["estimativa"] == "valida"]
    rejeitados = sum(r["estimativa"] == "rejeitada" for r in linhas)
    erros = [r["erro_angular_deg"] for r in validos]
    n = len(validos) + rejeitados
    media_erro, desvio = None, None
    if erros:
        seno = mean(math.sin(math.radians(e)) for e in erros)
        cosseno = mean(math.cos(math.radians(e)) for e in erros)
        concentracao = min(1.0, math.hypot(seno, cosseno))
        if concentracao > 1e-12:
            media_erro = (math.degrees(math.atan2(seno, cosseno)) + 180) % 360 - 180
            if len(erros) >= 2:
                desvio = math.degrees(math.sqrt(max(0, -2 * math.log(concentracao))))
    return {
        "data_hora": inicio.isoformat(timespec="seconds"),
        "ambiente": ambiente, "distancia_m": distancia,
        "angulo_real_deg": real, "repeticao": rep, "status_coleta": status,
        "duracao_pc_s": round(observado, 4),
        "n_validas": len(validos), "n_rejeitadas": rejeitados,
        "n_nao_interpretadas": len(linhas) - n,
        "validas_pct": 100 * len(validos) / n if n else None,
        "MAE_deg": mean(abs(e) for e in erros) if erros else None,
        "angulo_medio_circular_deg": (real + media_erro) % 360 if media_erro is not None else None,
        "media_erro_circular_deg": media_erro,
        "desvio_circular_deg": desvio,
        "erro_abs_max_deg": max(map(abs, erros)) if erros else None,
        "detalhe": detalhe,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("acao", nargs="?", choices=["coletar", "portas"], default="coletar")
    parser.add_argument("--porta", default=PORTA)
    parser.add_argument("--baud", type=int, default=BAUD)
    parser.add_argument("--ambiente", default=AMBIENTE)
    parser.add_argument("--distancia", type=float, default=DISTANCIA_M)
    parser.add_argument("--angulo", "--angulos", dest="angulos", type=validar_angulo,
                        nargs="+", default=None, help="Opcional: graus livres; sem argumento, pergunta no terminal.")
    parser.add_argument("--repeticoes", type=int, default=None,
                        help="Opcional: sem argumento, pergunta a cada sequencia.")
    parser.add_argument("--segundos", type=float, default=DURACAO_S)
    parser.add_argument("--saida", type=Path, default=PASTA_BASE)
    parser.add_argument("--wav", default=ARQUIVO_WAV)
    parser.add_argument("--sem-audio", action="store_true")
    a = parser.parse_args()

    try:
        import serial
        from serial.tools import list_ports
    except ImportError:
        parser.error("Instale a dependencia: py -m pip install pyserial")
    if a.acao == "portas":
        for p in list_ports.comports():
            print(p.device, "-", p.description)
        return
    if not math.isfinite(a.distancia) or a.distancia <= 0:
        parser.error("A distancia deve ser positiva.")
    if (not math.isfinite(a.segundos) or a.segundos <= 0
            or (a.repeticoes is not None and a.repeticoes < 1)):
        parser.error("Duracao e numero de repeticoes devem ser positivos.")
    if a.angulos is not None and len(set(a.angulos)) != len(a.angulos):
        parser.error("Use angulos distintos entre 0 e 359 graus.")
    if (not a.ambiente.strip() or a.ambiente in (".", "..")
            or re.search(r'[<>:"/\\|?*]', a.ambiente)
            or a.ambiente.endswith((".", " "))):
        parser.error("Ambiente deve ser um unico nome de pasta valido.")

    wav, tocar = None, None
    if a.wav and not a.sem_audio:
        try:
            import winsound
        except ImportError:
            parser.error("Reproducao automatica requer Windows; use --sem-audio.")
        wav = Path(a.wav)
        if not wav.is_absolute():
            wav = Path(__file__).resolve().parent / wav
        try:
            with wave.open(str(wav), "rb") as w:
                if (w.getnchannels() != 1 or w.getsampwidth() != 2
                        or w.getframerate() not in (44100, 48000)
                        or abs(w.getnframes() / w.getframerate() - a.segundos) > 1 / w.getframerate()):
                    parser.error("Use WAV PCM mono 16 bits, 44,1/48 kHz, com a duracao da coleta.")
        except (OSError, wave.Error, EOFError) as exc:
            parser.error(f"Nao foi possivel abrir o WAV: {exc}")

        def tocar(caminho):
            flags = winsound.SND_FILENAME | winsound.SND_ASYNC | winsound.SND_NODEFAULT
            winsound.PlaySound(caminho, flags if caminho else 0)

    try:
        with serial.Serial(a.porta, a.baud, timeout=0.02) as ser:
            time.sleep(2)
            for angulo, quantidade in escolher_sequencias(a.angulos, a.repeticoes):
                pasta = pasta_condicao(a.saida, a.ambiente, a.distancia, angulo)
                pasta.mkdir(parents=True, exist_ok=True)
                for tentativa in range(1, quantidade + 1):
                    rep = proxima_repeticao(pasta)
                    print(f"\n{a.ambiente} | {a.distancia:g} m | {angulo:g} graus | rep{rep:03d}")
                    if input(f"Ensaio {tentativa}/{quantidade}. Enter inicia; q encerra: ").strip().lower() == "q":
                        return
                    prefixo = f"rep{rep:03d}"
                    inicio, recebidos, status, detalhe, observado = capturar(
                        ser, pasta / f"{prefixo}_serial.txt", a.segundos, wav, tocar
                    )
                    linhas = converter(recebidos, inicio, rep, angulo, a.segundos)
                    escrever_csv(pasta / f"{prefixo}_dados.csv", linhas, COLUNAS)
                    resumo = resumir(linhas, inicio, rep, a.ambiente, a.distancia,
                                     angulo, status, observado, detalhe)
                    escrever_csv(pasta / "resumo.csv", [resumo], list(resumo), anexar=True)
                    print(f"Salvo: {pasta / prefixo} | {len(linhas)} registros | {status}")
                    if not linhas:
                        print("ATENCAO: nenhum registro ANGLE reconhecido; confira o TXT.")
                    elif not any(r["TDOA12_amostras"] is not None for r in linhas):
                        print("TDOAs ausentes: confira se o firmware envia TAU1000.")
                    if status != "concluida":
                        print("Coleta parcial preservada.", detalhe)
                        return
    except (KeyboardInterrupt, EOFError):
        print("\nEncerrado.")
    except (serial.SerialException, OSError) as exc:
        parser.exit(1, f"Erro: {exc}\n")


if __name__ == "__main__":
    main()
