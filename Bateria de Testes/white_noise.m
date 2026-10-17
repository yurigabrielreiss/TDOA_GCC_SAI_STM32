clear;
clc;

cfg.fs = 48000;          % Pode trocar para 44100.
cfg.duracao_s = 200;
cfg.bits = 16;
cfg.semente = 20261015;

% Referência digital: 20*log10(RMS/1).
% Esse valor NÃO especifica o nível acústico em dB SPL.
cfg.rms_dbfs = -18;
cfg.rampa_s = 0.005;
cfg.matlab = version;

rng(cfg.semente, 'twister');

N = round(cfg.fs * cfg.duracao_s);

% Ruído branco gaussiano, mono.
x = randn(N, 1);
x = x - mean(x);

% Rampas curtas para suavizar início e fim.
nr = round(cfg.rampa_s * cfg.fs);
assert(nr >= 2 && 2*nr <= N, 'Rampa incompatível com a duração.');

rampa = 0.5 - 0.5*cos(linspace(0, pi, nr).');

x(1:nr) = x(1:nr) .* rampa;
x(end-nr+1:end) = x(end-nr+1:end) .* flipud(rampa);

% Ajusta o RMS depois de aplicar as rampas.
rms_alvo = 10^(cfg.rms_dbfs/20);
x = x * rms_alvo / sqrt(mean(x.^2));

cfg.pico = max(abs(x));
cfg.rms_obtido_dbfs = 20*log10(sqrt(mean(x.^2)));

% Não aplica clipping nem muda silenciosamente o nível escolhido.
assert(cfg.pico < 0.99, ...
    'Pico muito alto. Reduza cfg.rms_dbfs e gere novamente.');

nome = sprintf('ruido_branco_%gs_%dHz', cfg.duracao_s, cfg.fs);

audiowrite([nome '.wav'], x, cfg.fs, ...
    'BitsPerSample', cfg.bits);

save([nome '_parametros.mat'], 'cfg');

fprintf('Arquivo: %s.wav\n', nome);
fprintf('Duração: %.3f s\n', N/cfg.fs);
fprintf('Amostras: %d | Canais: 1 | Bits: %d\n', N, cfg.bits);
fprintf('RMS digital: %.2f dBFS\n', cfg.rms_obtido_dbfs);
fprintf('Pico: %.4f\n', cfg.pico);

% Para ouvir sem normalização automática:
% sound(x, cfg.fs);