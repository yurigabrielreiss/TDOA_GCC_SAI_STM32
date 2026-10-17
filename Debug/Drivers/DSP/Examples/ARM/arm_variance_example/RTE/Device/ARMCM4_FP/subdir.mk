################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/startup_ARMCM4.s 

C_SRCS += \
../Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/system_ARMCM4.c 

OBJS += \
./Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/startup_ARMCM4.o \
./Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/system_ARMCM4.o 

S_DEPS += \
./Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/startup_ARMCM4.d 

C_DEPS += \
./Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/system_ARMCM4.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/%.o: ../Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/%.s Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"
Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/%.o Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/%.su Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/%.cyclo: ../Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/%.c Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -D__FPU_PRESENT=1U -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../Core/Inc -I../Drivers/DSP/Include -I../Drivers/DSP/PrivateInclude -I../Drivers/STM32G4xx_HAL_Driver/Inc -I../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-DSP-2f-Examples-2f-ARM-2f-arm_variance_example-2f-RTE-2f-Device-2f-ARMCM4_FP

clean-Drivers-2f-DSP-2f-Examples-2f-ARM-2f-arm_variance_example-2f-RTE-2f-Device-2f-ARMCM4_FP:
	-$(RM) ./Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/startup_ARMCM4.d ./Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/startup_ARMCM4.o ./Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/system_ARMCM4.cyclo ./Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/system_ARMCM4.d ./Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/system_ARMCM4.o ./Drivers/DSP/Examples/ARM/arm_variance_example/RTE/Device/ARMCM4_FP/system_ARMCM4.su

.PHONY: clean-Drivers-2f-DSP-2f-Examples-2f-ARM-2f-arm_variance_example-2f-RTE-2f-Device-2f-ARMCM4_FP

