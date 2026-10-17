################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM0.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM23.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM3.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM33.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM4.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM7.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC000.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC300.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MBL.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MML.c \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_generic.c 

S_UPPER_SRCS += \
../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/startup_generic.S 

OBJS += \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/startup_generic.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM0.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM23.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM3.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM33.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM4.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM7.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC000.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC300.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MBL.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MML.o \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_generic.o 

S_UPPER_DEPS += \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/startup_generic.d 

C_DEPS += \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM0.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM23.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM3.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM33.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM4.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM7.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC000.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC300.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MBL.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MML.d \
./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_generic.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/DSP/DSP_Lib_TestSuite/Common/platform/%.o: ../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/%.S Drivers/DSP/DSP_Lib_TestSuite/Common/platform/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"
Drivers/DSP/DSP_Lib_TestSuite/Common/platform/%.o Drivers/DSP/DSP_Lib_TestSuite/Common/platform/%.su Drivers/DSP/DSP_Lib_TestSuite/Common/platform/%.cyclo: ../Drivers/DSP/DSP_Lib_TestSuite/Common/platform/%.c Drivers/DSP/DSP_Lib_TestSuite/Common/platform/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -D__FPU_PRESENT=1U -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../Core/Inc -I../Drivers/DSP/Include -I../Drivers/DSP/PrivateInclude -I../Drivers/STM32G4xx_HAL_Driver/Inc -I../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-platform

clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-platform:
	-$(RM) ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/startup_generic.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/startup_generic.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM0.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM0.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM0.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM0.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM23.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM23.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM23.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM23.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM3.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM3.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM3.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM3.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM33.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM33.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM33.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM33.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM4.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM4.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM4.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM4.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM7.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM7.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM7.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMCM7.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC000.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC000.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC000.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC000.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC300.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC300.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC300.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMSC300.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MBL.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MBL.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MBL.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MBL.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MML.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MML.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MML.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_ARMv8MML.su ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_generic.cyclo ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_generic.d ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_generic.o ./Drivers/DSP/DSP_Lib_TestSuite/Common/platform/system_generic.su

.PHONY: clean-Drivers-2f-DSP-2f-DSP_Lib_TestSuite-2f-Common-2f-platform

