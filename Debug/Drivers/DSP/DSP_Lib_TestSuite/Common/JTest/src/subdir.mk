################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_cycle.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_dump_str_segments.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_fw.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_trigger_action.c 

OBJS += \
./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_cycle.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_dump_str_segments.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_fw.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_trigger_action.o 

C_DEPS += \
./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_cycle.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_dump_str_segments.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_fw.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_trigger_action.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/%.o Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/%.su Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/%.cyclo: ../Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/%.c Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -D__FPU_PRESENT=1U -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../Core/Inc -I../Drivers/DSP/Include -I../Drivers/DSP/PrivateInclude -I../Drivers/STM32G4xx_HAL_Driver/Inc -I../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-JTest-2f-src

clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-JTest-2f-src:
	-$(RM) ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_cycle.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_cycle.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_cycle.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_cycle.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_dump_str_segments.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_dump_str_segments.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_dump_str_segments.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_dump_str_segments.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_fw.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_fw.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_fw.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_fw.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_trigger_action.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_trigger_action.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_trigger_action.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/JTest/src/jtest_trigger_action.su

.PHONY: clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-JTest-2f-src

