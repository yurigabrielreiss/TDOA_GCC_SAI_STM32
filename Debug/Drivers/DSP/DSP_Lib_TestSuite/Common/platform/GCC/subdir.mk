################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/Retarget.c 

S_UPPER_SRCS += \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/startup_armv6-m.S \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/startup_armv7-m.S 

OBJS += \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/Retarget.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/startup_armv6-m.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/startup_armv7-m.o 

S_UPPER_DEPS += \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/startup_armv6-m.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/startup_armv7-m.d 

C_DEPS += \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/Retarget.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/%.o Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/%.su Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/%.cyclo: ../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/%.c Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -D__FPU_PRESENT=1U -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../Core/Inc -I../Drivers/DSP/Include -I../Drivers/DSP/PrivateInclude -I../Drivers/STM32G4xx_HAL_Driver/Inc -I../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/%.o: ../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/%.S Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-platform-2f-GCC

clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-platform-2f-GCC:
	-$(RM) ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/Retarget.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/Retarget.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/Retarget.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/Retarget.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/startup_armv6-m.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/startup_armv6-m.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/startup_armv7-m.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/GCC/startup_armv7-m.o

.PHONY: clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-platform-2f-GCC

