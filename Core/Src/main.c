/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * @file           : main.c
 * @brief          : Main program body
 ******************************************************************************
 * @attention
 *
 * Copyright (c) 2026 STMicroelectronics.
 * All rights reserved.
 *
 * This software is licensed under terms that can be found in the LICENSE file
 * in the root directory of this software component.
 * If no LICENSE file comes with this software, it is provided AS-IS.
 *
 ******************************************************************************
 */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "arm_math.h"
#include "arm_const_structs.h"
/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
#define SAI_A_BUFFER_SIZE 4096
#define SAI_B_BUFFER_SIZE 4096

#define AUDIO_FRAMES 1024

#define READY_A 0x01 // =00000001
#define READY_B 0x02 // =00000010
#define READY_BOTH 0x03 // =00000011 = READY_A OR READY_B

// trigger pra captura automatica com rms
#define TRIGGER_RMS 0.020f
#define RELEASE_RMS 0.005f
#define RELEASE_BLOCKS 3

// constantes GCC-PHAT.
#define GCC_WINDOW_SIZE 256
#define GCC_FFT_SIZE 512
#define GCC_WINDOW_OFFSET 384

#define GCC_MAX_LAG 14
#define GCC_PHYSICAL_MAX_LAG 14.5f
#define GCC_MAX_CLOSURE 0.50f

#define AUDIO_FS 48076.9230769f
#define PCM_24_SCALE 8388608.0f

#define GCC_EPSILON 1.0e-12f
#define GCC_MIN_RMS 0.0005f

#define ENABLE_AUTO_CAPTURE 0

#define SPEED_OF_SOUND 343.0f
#define MIC_DISTANCE_M 0.10f // 10cm

#define RAD_TO_DEG 57.2957795131f // 180/pi
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
SAI_HandleTypeDef hsai_BlockA1;
SAI_HandleTypeDef hsai_BlockB1;
DMA_HandleTypeDef hdma_sai1_a;
DMA_HandleTypeDef hdma_sai1_b;

UART_HandleTypeDef huart2;

/* USER CODE BEGIN PV */
volatile uint32_t saiA_buffer[SAI_A_BUFFER_SIZE];
volatile uint32_t saiB_buffer[SAI_B_BUFFER_SIZE];

int32_t mic1[AUDIO_FRAMES];
int32_t mic2[AUDIO_FRAMES];
int32_t mic3[AUDIO_FRAMES];

int32_t capture_mic1[AUDIO_FRAMES];
int32_t capture_mic2[AUDIO_FRAMES];
int32_t capture_mic3[AUDIO_FRAMES];

static float32_t fft_mic1[2 * GCC_FFT_SIZE];
static float32_t fft_mic2[2 * GCC_FFT_SIZE];
static float32_t fft_mic3[2 * GCC_FFT_SIZE];

// Buffer temporário para: X * conj(Y) e posteriormente IFFT.
static float32_t gcc_work[2 * GCC_FFT_SIZE];

volatile float32_t tdoa12_samples = 0.0f;
volatile float32_t tdoa13_samples = 0.0f;
volatile float32_t tdoa23_samples = 0.0f;

float32_t gcc12_quality = 0.0f;
float32_t gcc13_quality = 0.0f;
float32_t gcc23_quality = 0.0f;

volatile float32_t closure_samples = 0.0f;

volatile uint8_t tdoa12_valid = 0;
volatile uint8_t tdoa13_valid = 0;
volatile uint8_t tdoa23_valid = 0;

volatile uint8_t tdoa_all_valid = 0;

volatile float mic1_rms = 0.0f;
volatile float mic2_rms = 0.0f;
volatile float mic3_rms = 0.0f;

volatile uint32_t saiA_half_count = 0;
volatile uint32_t saiA_full_count = 0;
volatile uint32_t saiA_error_count = 0;

volatile uint32_t saiB_half_count = 0;
volatile uint32_t saiB_full_count = 0;
volatile uint32_t saiB_error_count = 0;

volatile int32_t mic1_min = 0;
volatile int32_t mic1_max = 0;
volatile int32_t mic2_min = 0;
volatile int32_t mic2_max = 0;

volatile uint8_t half_ready_mask = 0;
volatile uint8_t full_ready_mask = 0;

volatile uint8_t audio_block_ready = 0;

static uint32_t last_uart_update = 0;
volatile uint8_t capture_request = 0;
volatile uint8_t capture_ready = 0;

volatile uint8_t event_armed = 1;
volatile uint8_t release_count = 0;

static float32_t hann_window[GCC_WINDOW_SIZE];

volatile uint8_t tdoa_solution_valid = 0;

float32_t current_event_rms = 0.0f;

// azimute
float32_t direction_x = 0.0f;
float32_t direction_y = 0.0f;
float32_t direction_norm = 0.0f;
float32_t azimuth_deg = 0.0f;

volatile uint8_t angle_valid = 0;
/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_DMA_Init(void);
static void MX_SAI1_Init(void);
static void MX_USART2_UART_Init(void);
/* USER CODE BEGIN PFP */
static float Calculate_RMS(const int32_t *buffer, int length);
static inline int32_t INMP441_Decode(uint32_t raw);
static void ProcessAudioBlock(uint32_t offset);

static void GCC_Init(void);
static uint8_t GCC_IsValid(float32_t tau);

static float32_t GCC_PHAT_FromFFT(const float32_t *fft_x, const float32_t *fft_y, float32_t *quality);
static float32_t GCC_GetCorrelationAtLag(const float32_t *corr, int lag);
static void GCC_PrepareFFT(const int32_t *input, float32_t *fft_out);

static uint8_t CalculateDirection(
    float32_t tau12,
    float32_t tau13,
    float32_t tau23,
    float32_t *ux,
    float32_t *uy,
    float32_t *norm,
    float32_t *angle);
/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{

  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_DMA_Init();
  MX_SAI1_Init();
  MX_USART2_UART_Init();
  /* USER CODE BEGIN 2 */
    GCC_Init();

    // Inicia o Block B primeiro
    if (HAL_SAI_Receive_DMA(&hsai_BlockB1, (uint8_t *)saiB_buffer, SAI_B_BUFFER_SIZE) != HAL_OK)
    {
        Error_Handler();
    }

    // Depois inicia o Block A, que gera SCK e FS
    if (HAL_SAI_Receive_DMA(&hsai_BlockA1, (uint8_t *)saiA_buffer, SAI_A_BUFFER_SIZE) != HAL_OK)
    {
        Error_Handler();
    }

  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
    while (1)
    {

        uint8_t cmd;

        if (HAL_UART_Receive(&huart2, &cmd, 1, 0) == HAL_OK)
        {
            if (cmd == 'C' || cmd == 'c')
            {
                capture_request = 1;

                char msg[] = "Captura solicitada...\r\n";

                HAL_UART_Transmit(&huart2, (uint8_t *)msg, strlen(msg), HAL_MAX_DELAY);
            }
        }
        /* Primeira metade do DMA */
        if (half_ready_mask == READY_BOTH)
        {
            __disable_irq();
            half_ready_mask = 0;
            __enable_irq();

            ProcessAudioBlock(0);
        }

        /* Segunda metade do DMA */
        if (full_ready_mask == READY_BOTH)
        {
            __disable_irq();
            full_ready_mask = 0;
            __enable_irq();

            ProcessAudioBlock(SAI_A_BUFFER_SIZE / 2);
        }

        // Telemetria do RMS dos mic
        if (HAL_GetTick() - last_uart_update >= 100)
        {
            last_uart_update = HAL_GetTick();

            char msg[384];
            int len;

            if (angle_valid)
            {
                int32_t angle_x100 =
                    (int32_t)(azimuth_deg * 100.0f);

                uint32_t norm_x1000 =
                    (uint32_t)(direction_norm * 1000.0f);

                int32_t closure_x1000 =
                    (int32_t)(closure_samples * 1000.0f);

                uint32_t q12_x100 =
                    (uint32_t)(gcc12_quality * 100.0f);

                uint32_t q13_x100 =
                    (uint32_t)(gcc13_quality * 100.0f);

                uint32_t q23_x100 =
                    (uint32_t)(gcc23_quality * 100.0f);

                uint32_t rms_x1e6 =
                    (uint32_t)(current_event_rms * 1000000.0f);

                len = snprintf(
                    msg,
                    sizeof(msg),

                    "ANGLE:%ld.%02ld "
                    "RMS:%lu "
                    "N:%lu.%03lu "
                    "C:%ld "
                    "Q:%lu.%02lu,%lu.%02lu,%lu.%02lu\r\n",

                    /* Ângulo */
                    (long)(angle_x100 / 100),
                    (long)labs(angle_x100 % 100),

                    // RMS
                    (unsigned long)rms_x1e6,

                    /* Norm */
                    (unsigned long)(norm_x1000 / 1000),
                    (unsigned long)(norm_x1000 % 1000),

                    /* Closure x1000 */
                    (long)closure_x1000,

                    /* Q12 */
                    (unsigned long)(q12_x100 / 100),
                    (unsigned long)(q12_x100 % 100),

                    /* Q13 */
                    (unsigned long)(q13_x100 / 100),
                    (unsigned long)(q13_x100 % 100),

                    /* Q23 */
                    (unsigned long)(q23_x100 / 100),
                    (unsigned long)(q23_x100 % 100));
            }


            else if (tdoa_all_valid)
            {
                int32_t closure_x1000 =
                    (int32_t)(closure_samples * 1000.0f);

                len = snprintf(
                    msg,
                    sizeof(msg),

                    "ANGLE:INVALID "
                    "C:%ld\r\n",

                    (long)closure_x1000);
            }

            else
            {
                len = snprintf(
                    msg,
                    sizeof(msg),

                    "ANGLE:INVALID "
                    "V:%u,%u,%u\r\n",

                    tdoa12_valid,
                    tdoa13_valid,
                    tdoa23_valid);
            }

            /*
             * Acrescenta os TDOAs e o motivo da rejeição à mensagem existente.
             *
             * TAU1000: atrasos em milésimos de amostra.
             * RMS:     amplitude normalizada multiplicada por 1.000.000.
             * MS:      instante de emissão da telemetria, em milissegundos.
             *
             */
            char tau_text[3][24];

            const float tau_values[3] = {
                tdoa12_samples,
                tdoa13_samples,
                tdoa23_samples
            };

            const uint8_t signal_present =
                current_event_rms >= GCC_MIN_RMS;

            for (int i = 0; i < 3; i++)
            {
                if (signal_present && isfinite(tau_values[i]))
                {
                    snprintf(
                        tau_text[i],
                        sizeof(tau_text[i]),
                        "%ld",
                        (long)lrintf(tau_values[i] * 1000.0f));
                }
                else
                {
                    /*
                     * Não transmite TDOAs antigos quando o RMS está baixo.
                     */
                    strcpy(tau_text[i], "NA");
                }
            }

            const char *reason;

            if (!signal_present)
                reason = "LOW_RMS";
            else if (!tdoa_all_valid)
                reason = "PAIR_INVALID";
            else if (!tdoa_solution_valid)
                reason = "CLOSURE";
            else if (!angle_valid)
                reason = "DIRECTION";
            else
                reason = "OK";

            /* Remove o fim de linha da mensagem original. */
            if (len < 0 || len >= (int)sizeof(msg))
                len = 0;

            while (len > 0 &&
                   (msg[len - 1] == '\r' || msg[len - 1] == '\n'))
            {
                len--;
            }

            int available = (int)sizeof(msg) - len;

            int extra = snprintf(
                msg + len,
                (size_t)available,
                " TAU1000:%s,%s,%s"
                " V:%u,%u,%u"
                " RMS:%lu"
                " REASON:%s"
                " MS:%lu\r\n",
                tau_text[0],
                tau_text[1],
                tau_text[2],
                (unsigned int)tdoa12_valid,
                (unsigned int)tdoa13_valid,
                (unsigned int)tdoa23_valid,
                (unsigned long)(current_event_rms * 1000000.0f),
                reason,
                (unsigned long)HAL_GetTick());

            if (extra < 0)
                extra = 0;

            if (extra >= available)
                extra = available - 1;

            len += extra;

            HAL_UART_Transmit(
                &huart2,
                (uint8_t *)msg,
                len,
                HAL_MAX_DELAY);
        }

        // ENVIO DA CAPTURA
        if (capture_ready)
        {
            capture_ready = 0;

            char line[100];

            int len = snprintf(
                line,
                sizeof(line),
                "sample,mic1,mic2,mic3\r\n");

            HAL_UART_Transmit(
                &huart2,
                (uint8_t *)line,
                len,
                HAL_MAX_DELAY);

            for (int i = 0; i < AUDIO_FRAMES; i++)
            {
                len = snprintf(
                    line,
                    sizeof(line),
                    "%d,%ld,%ld,%ld\r\n",
                    i,
                    (long)capture_mic1[i],
                    (long)capture_mic2[i],
                    (long)capture_mic3[i]);

                HAL_UART_Transmit(
                    &huart2,
                    (uint8_t *)line,
                    len,
                    HAL_MAX_DELAY);
            }

            char msg[] = "\r\nFim da captura.\r\n";

            HAL_UART_Transmit(
                &huart2,
                (uint8_t *)msg,
                strlen(msg),
                HAL_MAX_DELAY);
        }

    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
    }
  /* USER CODE END 3 */
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

  /** Configure the main internal regulator output voltage
  */
  HAL_PWREx_ControlVoltageScaling(PWR_REGULATOR_VOLTAGE_SCALE1_BOOST);

  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSI;
  RCC_OscInitStruct.PLL.PLLM = RCC_PLLM_DIV1;
  RCC_OscInitStruct.PLL.PLLN = 20;
  RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV2;
  RCC_OscInitStruct.PLL.PLLQ = RCC_PLLQ_DIV4;
  RCC_OscInitStruct.PLL.PLLR = RCC_PLLR_DIV2;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }

  /** Initializes the CPU, AHB and APB buses clocks
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV1;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_4) != HAL_OK)
  {
    Error_Handler();
  }
  HAL_RCC_MCOConfig(RCC_MCO1, RCC_MCO1SOURCE_SYSCLK, RCC_MCODIV_8);
}

/**
  * @brief SAI1 Initialization Function
  * @param None
  * @retval None
  */
static void MX_SAI1_Init(void)
{

  /* USER CODE BEGIN SAI1_Init 0 */

  /* USER CODE END SAI1_Init 0 */

  /* USER CODE BEGIN SAI1_Init 1 */

  /* USER CODE END SAI1_Init 1 */
  hsai_BlockA1.Instance = SAI1_Block_A;
  hsai_BlockA1.Init.AudioMode = SAI_MODEMASTER_RX;
  hsai_BlockA1.Init.Synchro = SAI_ASYNCHRONOUS;
  hsai_BlockA1.Init.OutputDrive = SAI_OUTPUTDRIVE_DISABLE;
  hsai_BlockA1.Init.NoDivider = SAI_MASTERDIVIDER_DISABLE;
  hsai_BlockA1.Init.MckOverSampling = SAI_MCK_OVERSAMPLING_DISABLE;
  hsai_BlockA1.Init.FIFOThreshold = SAI_FIFOTHRESHOLD_EMPTY;
  hsai_BlockA1.Init.AudioFrequency = SAI_AUDIO_FREQUENCY_48K;
  hsai_BlockA1.Init.SynchroExt = SAI_SYNCEXT_DISABLE;
  hsai_BlockA1.Init.MonoStereoMode = SAI_STEREOMODE;
  hsai_BlockA1.Init.CompandingMode = SAI_NOCOMPANDING;
  if (HAL_SAI_InitProtocol(&hsai_BlockA1, SAI_I2S_STANDARD, SAI_PROTOCOL_DATASIZE_24BIT, 2) != HAL_OK)
  {
    Error_Handler();
  }
  hsai_BlockB1.Instance = SAI1_Block_B;
  hsai_BlockB1.Init.AudioMode = SAI_MODESLAVE_RX;
  hsai_BlockB1.Init.Synchro = SAI_SYNCHRONOUS;
  hsai_BlockB1.Init.OutputDrive = SAI_OUTPUTDRIVE_DISABLE;
  hsai_BlockB1.Init.FIFOThreshold = SAI_FIFOTHRESHOLD_EMPTY;
  hsai_BlockB1.Init.SynchroExt = SAI_SYNCEXT_DISABLE;
  hsai_BlockB1.Init.MonoStereoMode = SAI_STEREOMODE;
  hsai_BlockB1.Init.CompandingMode = SAI_NOCOMPANDING;
  hsai_BlockB1.Init.TriState = SAI_OUTPUT_NOTRELEASED;
  if (HAL_SAI_InitProtocol(&hsai_BlockB1, SAI_I2S_STANDARD, SAI_PROTOCOL_DATASIZE_24BIT, 2) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN SAI1_Init 2 */

  /* USER CODE END SAI1_Init 2 */

}

/**
  * @brief USART2 Initialization Function
  * @param None
  * @retval None
  */
static void MX_USART2_UART_Init(void)
{

  /* USER CODE BEGIN USART2_Init 0 */

  /* USER CODE END USART2_Init 0 */

  /* USER CODE BEGIN USART2_Init 1 */

  /* USER CODE END USART2_Init 1 */
  huart2.Instance = USART2;
  huart2.Init.BaudRate = 115200;
  huart2.Init.WordLength = UART_WORDLENGTH_8B;
  huart2.Init.StopBits = UART_STOPBITS_1;
  huart2.Init.Parity = UART_PARITY_NONE;
  huart2.Init.Mode = UART_MODE_TX_RX;
  huart2.Init.HwFlowCtl = UART_HWCONTROL_NONE;
  huart2.Init.OverSampling = UART_OVERSAMPLING_16;
  huart2.Init.OneBitSampling = UART_ONE_BIT_SAMPLE_DISABLE;
  huart2.Init.ClockPrescaler = UART_PRESCALER_DIV1;
  huart2.AdvancedInit.AdvFeatureInit = UART_ADVFEATURE_NO_INIT;
  if (HAL_UART_Init(&huart2) != HAL_OK)
  {
    Error_Handler();
  }
  if (HAL_UARTEx_SetTxFifoThreshold(&huart2, UART_TXFIFO_THRESHOLD_1_8) != HAL_OK)
  {
    Error_Handler();
  }
  if (HAL_UARTEx_SetRxFifoThreshold(&huart2, UART_RXFIFO_THRESHOLD_1_8) != HAL_OK)
  {
    Error_Handler();
  }
  if (HAL_UARTEx_DisableFifoMode(&huart2) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN USART2_Init 2 */

  /* USER CODE END USART2_Init 2 */

}

/**
  * Enable DMA controller clock
  */
static void MX_DMA_Init(void)
{

  /* DMA controller clock enable */
  __HAL_RCC_DMAMUX1_CLK_ENABLE();
  __HAL_RCC_DMA1_CLK_ENABLE();

  /* DMA interrupt init */
  /* DMA1_Channel1_IRQn interrupt configuration */
  HAL_NVIC_SetPriority(DMA1_Channel1_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(DMA1_Channel1_IRQn);
  /* DMA1_Channel2_IRQn interrupt configuration */
  HAL_NVIC_SetPriority(DMA1_Channel2_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(DMA1_Channel2_IRQn);

}

/**
  * @brief GPIO Initialization Function
  * @param None
  * @retval None
  */
static void MX_GPIO_Init(void)
{
  GPIO_InitTypeDef GPIO_InitStruct = {0};
  /* USER CODE BEGIN MX_GPIO_Init_1 */

  /* USER CODE END MX_GPIO_Init_1 */

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOA_CLK_ENABLE();
  __HAL_RCC_GPIOB_CLK_ENABLE();

  /*Configure GPIO pin : PA8 */
  GPIO_InitStruct.Pin = GPIO_PIN_8;
  GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  GPIO_InitStruct.Alternate = GPIO_AF0_MCO;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  /* USER CODE BEGIN MX_GPIO_Init_2 */

  /* USER CODE END MX_GPIO_Init_2 */
}

/* USER CODE BEGIN 4 */
static uint8_t GCC_IsValid(
    float32_t tau)
{
    if (!isfinite(tau))
    {
        return 0;
    }

    if (fabsf(tau) > GCC_PHYSICAL_MAX_LAG)
    {
        return 0;
    }

    return 1;
}

static void GCC_PrepareFFT(
    const int32_t *input,
    float32_t *fft_out)
{
    float32_t mean = 0.0f;

    /*
     * Remove componente DC.
     */
    for (int i = 0; i < GCC_WINDOW_SIZE; i++)
    {
        mean += (float32_t)input[i];
    }

    mean /= (float32_t)GCC_WINDOW_SIZE;

    /*
     * Monta sinal complexo:
     *
     * real = áudio normalizado * Hann
     * imag = 0
     *
     * e completa com zeros até 256.
     */
    for (int i = 0; i < GCC_FFT_SIZE; i++)
    {
        if (i < GCC_WINDOW_SIZE)
        {
            float32_t sample =
                ((float32_t)input[i] - mean) /
                PCM_24_SCALE;

            fft_out[2 * i] =
                sample * hann_window[i];

            fft_out[2 * i + 1] = 0.0f;
        }
        else
        {
            fft_out[2 * i] = 0.0f;
            fft_out[2 * i + 1] = 0.0f;
        }
    }

    /*
     * FFT complexa.
     */
    arm_cfft_f32(
        &arm_cfft_sR_f32_len512,
        fft_out,
        0,
        1);
}
static void GCC_Init(void)
{
    for (int n = 0; n < GCC_WINDOW_SIZE; n++)
    {
        hann_window[n] =
            0.5f -
            0.5f * cosf(
                       (2.0f * 3.14159265358979323846f * (float)n) /
                       (float)(GCC_WINDOW_SIZE - 1));
    }
}

static float32_t GCC_GetCorrelationAtLag(
    const float32_t *corr,
    int lag)
{
    int index;

    if (lag >= 0)
    {
        index = lag;
    }
    else
    {
        index = GCC_FFT_SIZE + lag;
    }

    /*
     * Resultado da IFFT é complexo intercalado:
     *
     * real0, imag0, real1, imag1...
     */
    return corr[2 * index];
}

static float32_t GCC_PHAT_FromFFT(
    const float32_t *fft_x,
    const float32_t *fft_y,
    float32_t *quality)
{
    /*
     * Cross-spectrum:
     *
     * R = X * conj(Y)
     *
     * seguido de PHAT:
     *
     * R /= |R|
     */

    for (int k = 0; k < GCC_FFT_SIZE; k++)
    {
        float32_t xr = fft_x[2 * k];
        float32_t xi = fft_x[2 * k + 1];

        float32_t yr = fft_y[2 * k];
        float32_t yi = fft_y[2 * k + 1];

        float32_t real =
            xr * yr + xi * yi;

        float32_t imag =
            xi * yr - xr * yi;

        float32_t magnitude =
            sqrtf(
                real * real +
                imag * imag);

        if (magnitude > GCC_EPSILON)
        {
            real /= magnitude;
            imag /= magnitude;
        }
        else
        {
            real = 0.0f;
            imag = 0.0f;
        }

        gcc_work[2 * k] = real;
        gcc_work[2 * k + 1] = imag;
    }

    /*
     * IFFT da correlação.
     */
    arm_cfft_f32(
        &arm_cfft_sR_f32_len512,
        gcc_work,
        1,
        1);

    /*
     * Busca do pico.
     */
    int best_lag = 0;

    float32_t best_value = -1.0e30f;
    float32_t sum_abs = 0.0f;

    for (int lag = -GCC_MAX_LAG;
         lag <= GCC_MAX_LAG;
         lag++)
    {
        float32_t value =
            GCC_GetCorrelationAtLag(
                gcc_work,
                lag);

        sum_abs += fabsf(value);

        if (value > best_value)
        {
            best_value = value;
            best_lag = lag;
        }
    }

    /*
     * Qualidade.
     */
    float32_t mean_abs =
        sum_abs /
        (float32_t)(2 * GCC_MAX_LAG + 1);

    if (quality != NULL)
    {
        *quality =
            best_value /
            (mean_abs + GCC_EPSILON);
    }

    /*
     * Interpolação parabólica.
     */
    float32_t ym1 =
        GCC_GetCorrelationAtLag(
            gcc_work,
            best_lag - 1);

    float32_t y0 =
        GCC_GetCorrelationAtLag(
            gcc_work,
            best_lag);

    float32_t yp1 =
        GCC_GetCorrelationAtLag(
            gcc_work,
            best_lag + 1);

    float32_t denominator =
        ym1 -
        2.0f * y0 +
        yp1;

    float32_t delta = 0.0f;

    if (fabsf(denominator) > GCC_EPSILON)
    {
        delta =
            0.5f *
            (ym1 - yp1) /
            denominator;

        if (delta > 1.0f)
            delta = 1.0f;

        if (delta < -1.0f)
            delta = -1.0f;
    }

    return (float32_t)best_lag +
           delta;
}

static void ProcessAudioBlock(uint32_t offset)
{
    for (int i = 0; i < AUDIO_FRAMES; i++)
    {
        mic1[i] = INMP441_Decode(saiA_buffer[offset + 2 * i]);
        mic2[i] = INMP441_Decode(saiA_buffer[offset + 2 * i + 1]);
        mic3[i] = INMP441_Decode(saiB_buffer[offset + 2 * i]);
    }

    float32_t gcc_rms1 =
        Calculate_RMS(
            &mic1[GCC_WINDOW_OFFSET],
            GCC_WINDOW_SIZE);

    float32_t gcc_rms2 =
        Calculate_RMS(
            &mic2[GCC_WINDOW_OFFSET],
            GCC_WINDOW_SIZE);

    float32_t gcc_rms3 =
        Calculate_RMS(
            &mic3[GCC_WINDOW_OFFSET],
            GCC_WINDOW_SIZE);

    float32_t event_rms = gcc_rms1;

    if (gcc_rms2 > event_rms)
    {
        event_rms = gcc_rms2;
    }

    if (gcc_rms3 > event_rms)
    {
        event_rms = gcc_rms3;
    }

    current_event_rms = event_rms;


    if (event_rms >= GCC_MIN_RMS)
    {
        GCC_PrepareFFT(
            &mic1[GCC_WINDOW_OFFSET],
            fft_mic1);

        GCC_PrepareFFT(
            &mic2[GCC_WINDOW_OFFSET],
            fft_mic2);

        GCC_PrepareFFT(
            &mic3[GCC_WINDOW_OFFSET],
            fft_mic3);

        tdoa12_samples =
            GCC_PHAT_FromFFT(
                fft_mic1,
                fft_mic2,
                &gcc12_quality);

        tdoa13_samples =
            GCC_PHAT_FromFFT(
                fft_mic1,
                fft_mic3,
                &gcc13_quality);

        tdoa23_samples =
            GCC_PHAT_FromFFT(
                fft_mic2,
                fft_mic3,
                &gcc23_quality);

        tdoa12_valid =
            GCC_IsValid(tdoa12_samples);

        tdoa13_valid =
            GCC_IsValid(tdoa13_samples);

        tdoa23_valid =
            GCC_IsValid(tdoa23_samples);

        tdoa_all_valid =
            tdoa12_valid &&
            tdoa13_valid &&
            tdoa23_valid;

        if (tdoa_all_valid)
        {
            closure_samples =
                tdoa13_samples -
                (tdoa12_samples +
                 tdoa23_samples);

            if (fabsf(closure_samples) <= GCC_MAX_CLOSURE)
            {
                tdoa_solution_valid = 1;
            }
            else
            {
                tdoa_solution_valid = 0;
            }
        }
        else
        {
            closure_samples = 0.0f;
            tdoa_solution_valid = 0;
        }
        if (tdoa_solution_valid)
        {
            angle_valid =
                CalculateDirection(
                    tdoa12_samples,
                    tdoa13_samples,
                    tdoa23_samples,

                    &direction_x,
                    &direction_y,

                    &direction_norm,

                    &azimuth_deg);
        }
        else
        {
            angle_valid = 0;
        }
    }
    else
    {
        tdoa12_valid = 0;
        tdoa13_valid = 0;
        tdoa23_valid = 0;

        tdoa_all_valid = 0;
        tdoa_solution_valid = 0;

        angle_valid = 0;

        closure_samples = 0.0f;
    }

#if ENABLE_AUTO_CAPTURE
     // Captura automática: uma captura quando a palma ultrapassa o threshold
    if (event_armed &&
        event_rms >= TRIGGER_RMS &&
        !capture_ready)
    {
        memcpy(capture_mic1, mic1, sizeof(mic1));
        memcpy(capture_mic2, mic2, sizeof(mic2));
        memcpy(capture_mic3, mic3, sizeof(mic3));

        capture_ready = 1;

        event_armed = 0;
        release_count = 0;
    }

    /*
     * Rearma somente depois que o som cair abaixo
     * do threshold inferior durante alguns blocos.
     */
    if (!event_armed)
    {
        if (event_rms <= RELEASE_RMS)
        {
            release_count++;

            if (release_count >= RELEASE_BLOCKS)
            {
                event_armed = 1;
                release_count = 0;
            }
        }
        else
        {
            release_count = 0;
        }
    }
#endif

     // Mantém o comando C como captura manual opcional.
    if (capture_request && !capture_ready)
    {
        memcpy(capture_mic1, mic1, sizeof(mic1));
        memcpy(capture_mic2, mic2, sizeof(mic2));
        memcpy(capture_mic3, mic3, sizeof(mic3));

        capture_request = 0;
        capture_ready = 1;
    }
}

static inline int32_t INMP441_Decode(uint32_t raw)
{
    int32_t sample = raw & 0x00FFFFFF;

    if (sample & 0x00800000)
    {
        sample |= 0xFF000000;
    }

    return sample;
}

static float Calculate_RMS(
    const int32_t *buffer,
    int length)
{
    float sum = 0.0f;

    for (int i = 0; i < length; i++)
    {
        float x =
            (float)buffer[i] /
            PCM_24_SCALE;

        sum += x * x;
    }

    return sqrtf(
        sum / (float)length);
}

static uint8_t CalculateDirection(
    float32_t tau12,
    float32_t tau13,
    float32_t tau23,
    float32_t *ux,
    float32_t *uy,
    float32_t *norm,
    float32_t *angle)
{

    const float32_t k =
        SPEED_OF_SOUND / AUDIO_FS;

    float32_t raw_x =
        k *
        (2.0f * tau12 +
         tau13 -
         tau23) /
        (3.0f *
         MIC_DISTANCE_M);

    float32_t raw_y =
        k *
        (tau13 +
         tau23) /
        (1.73205080757f *
         MIC_DISTANCE_M);

    float32_t n =
        sqrtf(
            raw_x * raw_x +
            raw_y * raw_y);

    if (!isfinite(n) ||
        n < 1.0e-6f)
    {
        return 0;
    }

    *norm = n;

    /*
     * Normaliza direção.
     */
    *ux = raw_x / n;
    *uy = raw_y / n;

    /*
     * atan2 padrão:
     *
     * +x = 0°
     * +y = 90°
     *
     * Nossa convenção:
     *
     * +y = 0°
     * +x = 90°
     */
    float32_t cartesian_deg =
        atan2f(
            *uy,
            *ux) *
        RAD_TO_DEG;

    float32_t azimuth =
        90.0f -
        cartesian_deg;

    while (azimuth < 0.0f)
    {
        azimuth += 360.0f;
    }

    while (azimuth >= 360.0f)
    {
        azimuth -= 360.0f;
    }

    *angle = azimuth;

    return 1;
}
/*
void HAL_SAI_RxHalfCpltCallback(SAI_HandleTypeDef *hsai)
{
    if (hsai->Instance == SAI1_Block_A)
    {
        saiA_half_count++;
    }
}
*/
void HAL_SAI_RxHalfCpltCallback(SAI_HandleTypeDef *hsai)
{
    if (hsai->Instance == SAI1_Block_A)
    {
        saiA_half_count++;
        half_ready_mask |= READY_A;
    }
    else if (hsai->Instance == SAI1_Block_B)
    {
        saiB_half_count++;
        half_ready_mask |= READY_B;
    }
}

void HAL_SAI_RxCpltCallback(SAI_HandleTypeDef *hsai)
{
    if (hsai->Instance == SAI1_Block_A)
    {
        saiA_full_count++;
        full_ready_mask |= READY_A;
    }
    else if (hsai->Instance == SAI1_Block_B)
    {
        saiB_full_count++;
        full_ready_mask |= READY_B;
    }
}

void HAL_SAI_ErrorCallback(SAI_HandleTypeDef *hsai)
{
    if (hsai->Instance == SAI1_Block_A)
    {
        saiA_error_count++;
    }
    else if (hsai->Instance == SAI1_Block_B)
    {
        saiB_error_count++;
    }
}
/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
    /* User can add his own implementation to report the HAL error return state */
    __disable_irq();
    while (1)
    {
    }
  /* USER CODE END Error_Handler_Debug */
}
#ifdef USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
    /* User can add his own implementation to report the file name and line number,
       ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */
