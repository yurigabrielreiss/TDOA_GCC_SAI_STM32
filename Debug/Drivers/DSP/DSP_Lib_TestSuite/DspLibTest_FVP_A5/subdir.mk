################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/DSP/DSP_Lib_TestSuite/DspLibTest_FVP_A5/main.c 

OBJS += \
./Drivers/DSP/DSP_Lib_TestSuite/DspLibTest_FVP_A5/main.o 

C_DEPS += \
./Drivers/DSP/DSP_Lib_TestSuite/DspLibTest_FVP_A5/main.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/DSP/DSP_Lib_TestSuite/DspLibTest_FVP_A5/%.o Drivers/DSP/DSP_Lib_TestSuite/DspLibTest_FVP_A5/%.su Drivers/DSP/DSP_Lib_TestSuite/DspLibTest_FVP_A5/%.cyclo: ../Drivers/DSP/DSP_Lib_TestSuite/DspLibTest_FVP_A5/%.c Drivers/DSP/DSP_Lib_TestSuite/DspLibTest_FVP_A5/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -D__FPU_PRESENT=1U -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../Core/Inc -I../Drivers/DSP/Include -I../Drivers/DSP/PrivateInclude -I../Drivers/STM32G4xx_HAL_Driver/Inc -I../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-DspLibTest_FVP_A5

clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-DspLibTest_FVP_A5:
	-$(RM) ./Drivers/DSP/DSP_Lib_TestSuite/DspLibTest_FVP_A5/main.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/DspLibTest_FVP_A5/main.d ./Drivers/DSP/DSP_Lib_TestSuite/DspLibTest_FVP_A5/main.o ./Drivers/DSP/DSP_Lib_TestSuite/DspLibTest_FVP_A5/main.su

.PHONY: clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-DspLibTest_FVP_A5

