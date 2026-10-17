################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/DSP/DSP_Lib_TestSuite/Common/src/all_tests.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/src/main.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/src/math_helper.c 

OBJS += \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/all_tests.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/main.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/math_helper.o 

C_DEPS += \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/all_tests.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/main.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/math_helper.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/DSP/DSP_Lib_TestSuite/Common/src/%.o Drivers/DSP/DSP_Lib_TestSuite/Common/src/%.su Drivers/DSP/DSP_Lib_TestSuite/Common/src/%.cyclo: ../Drivers/DSP/DSP_Lib_TestSuite/Common/src/%.c Drivers/DSP/DSP_Lib_TestSuite/Common/src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -D__FPU_PRESENT=1U -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../Core/Inc -I../Drivers/DSP/Include -I../Drivers/DSP/PrivateInclude -I../Drivers/STM32G4xx_HAL_Driver/Inc -I../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-src

clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-src:
	-$(RM) ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/all_tests.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/all_tests.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/all_tests.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/all_tests.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/main.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/main.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/main.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/main.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/math_helper.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/math_helper.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/math_helper.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/math_helper.su

.PHONY: clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-src

