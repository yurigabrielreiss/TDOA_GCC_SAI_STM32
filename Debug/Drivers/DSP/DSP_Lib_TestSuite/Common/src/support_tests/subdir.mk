################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/copy_tests.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/fill_tests.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_common_data.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_group.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/x_to_y_tests.c 

OBJS += \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/copy_tests.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/fill_tests.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_common_data.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_group.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/x_to_y_tests.o 

C_DEPS += \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/copy_tests.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/fill_tests.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_common_data.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_group.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/x_to_y_tests.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/%.o Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/%.su Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/%.cyclo: ../Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/%.c Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -D__FPU_PRESENT=1U -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../Core/Inc -I../Drivers/DSP/Include -I../Drivers/DSP/PrivateInclude -I../Drivers/STM32G4xx_HAL_Driver/Inc -I../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-src-2f-support_tests

clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-src-2f-support_tests:
	-$(RM) ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/copy_tests.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/copy_tests.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/copy_tests.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/copy_tests.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/fill_tests.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/fill_tests.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/fill_tests.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/fill_tests.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_common_data.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_common_data.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_common_data.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_common_data.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_group.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_group.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_group.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/support_test_group.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/x_to_y_tests.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/x_to_y_tests.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/x_to_y_tests.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/src/support_tests/x_to_y_tests.su

.PHONY: clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-src-2f-support_tests

