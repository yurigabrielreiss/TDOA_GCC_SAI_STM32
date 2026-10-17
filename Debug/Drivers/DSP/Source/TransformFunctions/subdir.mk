################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/DSP/Source/TransformFunctions/TransformFunctions.c \
../Drivers/DSP/Source/TransformFunctions/arm_bitreversal.c \
../Drivers/DSP/Source/TransformFunctions/arm_bitreversal2.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_f32.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_q15.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_q31.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.c \
../Drivers/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.c \
../Drivers/DSP/Source/TransformFunctions/arm_dct4_f32.c \
../Drivers/DSP/Source/TransformFunctions/arm_dct4_init_f32.c \
../Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q15.c \
../Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q31.c \
../Drivers/DSP/Source/TransformFunctions/arm_dct4_q15.c \
../Drivers/DSP/Source/TransformFunctions/arm_dct4_q31.c \
../Drivers/DSP/Source/TransformFunctions/arm_rfft_f32.c \
../Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_f32.c \
../Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.c \
../Drivers/DSP/Source/TransformFunctions/arm_rfft_init_f32.c \
../Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q15.c \
../Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q31.c \
../Drivers/DSP/Source/TransformFunctions/arm_rfft_q15.c \
../Drivers/DSP/Source/TransformFunctions/arm_rfft_q31.c 

S_UPPER_SRCS += \
../Drivers/DSP/Source/TransformFunctions/arm_bitreversal2.S 

OBJS += \
./Drivers/DSP/Source/TransformFunctions/TransformFunctions.o \
./Drivers/DSP/Source/TransformFunctions/arm_bitreversal.o \
./Drivers/DSP/Source/TransformFunctions/arm_bitreversal2.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_f32.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_q15.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_q31.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.o \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.o \
./Drivers/DSP/Source/TransformFunctions/arm_dct4_f32.o \
./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_f32.o \
./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q15.o \
./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q31.o \
./Drivers/DSP/Source/TransformFunctions/arm_dct4_q15.o \
./Drivers/DSP/Source/TransformFunctions/arm_dct4_q31.o \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_f32.o \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_f32.o \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.o \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_f32.o \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q15.o \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q31.o \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_q15.o \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_q31.o 

S_UPPER_DEPS += \
./Drivers/DSP/Source/TransformFunctions/arm_bitreversal2.d 

C_DEPS += \
./Drivers/DSP/Source/TransformFunctions/TransformFunctions.d \
./Drivers/DSP/Source/TransformFunctions/arm_bitreversal.d \
./Drivers/DSP/Source/TransformFunctions/arm_bitreversal2.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_f32.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_q15.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_q31.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.d \
./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.d \
./Drivers/DSP/Source/TransformFunctions/arm_dct4_f32.d \
./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_f32.d \
./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q15.d \
./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q31.d \
./Drivers/DSP/Source/TransformFunctions/arm_dct4_q15.d \
./Drivers/DSP/Source/TransformFunctions/arm_dct4_q31.d \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_f32.d \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_f32.d \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.d \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_f32.d \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q15.d \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q31.d \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_q15.d \
./Drivers/DSP/Source/TransformFunctions/arm_rfft_q31.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/DSP/Source/TransformFunctions/%.o Drivers/DSP/Source/TransformFunctions/%.su Drivers/DSP/Source/TransformFunctions/%.cyclo: ../Drivers/DSP/Source/TransformFunctions/%.c Drivers/DSP/Source/TransformFunctions/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -D__FPU_PRESENT=1U -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../Core/Inc -I../Drivers/DSP/Include -I../Drivers/DSP/PrivateInclude -I../Drivers/STM32G4xx_HAL_Driver/Inc -I../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Drivers/DSP/Source/TransformFunctions/%.o: ../Drivers/DSP/Source/TransformFunctions/%.S Drivers/DSP/Source/TransformFunctions/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Drivers-2f-DSP-2f-Source-2f-TransformFunctions

clean-Drivers-2f-DSP-2f-Source-2f-TransformFunctions:
	-$(RM) ./Drivers/DSP/Source/TransformFunctions/TransformFunctions.cyclo ./Drivers/DSP/Source/TransformFunctions/TransformFunctions.d ./Drivers/DSP/Source/TransformFunctions/TransformFunctions.o ./Drivers/DSP/Source/TransformFunctions/TransformFunctions.su ./Drivers/DSP/Source/TransformFunctions/arm_bitreversal.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_bitreversal.d ./Drivers/DSP/Source/TransformFunctions/arm_bitreversal.o ./Drivers/DSP/Source/TransformFunctions/arm_bitreversal.su ./Drivers/DSP/Source/TransformFunctions/arm_bitreversal2.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_bitreversal2.d ./Drivers/DSP/Source/TransformFunctions/arm_bitreversal2.o ./Drivers/DSP/Source/TransformFunctions/arm_bitreversal2.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_f32.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_f32.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_f32.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_f32.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_q15.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_q15.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_q15.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_q15.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_q31.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_q31.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_q31.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_q31.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.su ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.d ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.o ./Drivers/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.su ./Drivers/DSP/Source/TransformFunctions/arm_dct4_f32.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_dct4_f32.d ./Drivers/DSP/Source/TransformFunctions/arm_dct4_f32.o ./Drivers/DSP/Source/TransformFunctions/arm_dct4_f32.su ./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_f32.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_f32.d ./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_f32.o ./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_f32.su ./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q15.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q15.d ./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q15.o ./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q15.su ./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q31.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q31.d ./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q31.o ./Drivers/DSP/Source/TransformFunctions/arm_dct4_init_q31.su ./Drivers/DSP/Source/TransformFunctions/arm_dct4_q15.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_dct4_q15.d ./Drivers/DSP/Source/TransformFunctions/arm_dct4_q15.o
	-$(RM) ./Drivers/DSP/Source/TransformFunctions/arm_dct4_q15.su ./Drivers/DSP/Source/TransformFunctions/arm_dct4_q31.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_dct4_q31.d ./Drivers/DSP/Source/TransformFunctions/arm_dct4_q31.o ./Drivers/DSP/Source/TransformFunctions/arm_dct4_q31.su ./Drivers/DSP/Source/TransformFunctions/arm_rfft_f32.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_rfft_f32.d ./Drivers/DSP/Source/TransformFunctions/arm_rfft_f32.o ./Drivers/DSP/Source/TransformFunctions/arm_rfft_f32.su ./Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_f32.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_f32.d ./Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_f32.o ./Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_f32.su ./Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.d ./Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.o ./Drivers/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.su ./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_f32.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_f32.d ./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_f32.o ./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_f32.su ./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q15.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q15.d ./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q15.o ./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q15.su ./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q31.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q31.d ./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q31.o ./Drivers/DSP/Source/TransformFunctions/arm_rfft_init_q31.su ./Drivers/DSP/Source/TransformFunctions/arm_rfft_q15.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_rfft_q15.d ./Drivers/DSP/Source/TransformFunctions/arm_rfft_q15.o ./Drivers/DSP/Source/TransformFunctions/arm_rfft_q15.su ./Drivers/DSP/Source/TransformFunctions/arm_rfft_q31.cyclo ./Drivers/DSP/Source/TransformFunctions/arm_rfft_q31.d ./Drivers/DSP/Source/TransformFunctions/arm_rfft_q31.o ./Drivers/DSP/Source/TransformFunctions/arm_rfft_q31.su

.PHONY: clean-Drivers-2f-DSP-2f-Source-2f-TransformFunctions

