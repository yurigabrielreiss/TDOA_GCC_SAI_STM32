################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/DSP/Source/CommonTables/CommonTables.c \
../Drivers/DSP/Source/CommonTables/arm_common_tables.c \
../Drivers/DSP/Source/CommonTables/arm_const_structs.c 

OBJS += \
./Drivers/DSP/Source/CommonTables/CommonTables.o \
./Drivers/DSP/Source/CommonTables/arm_common_tables.o \
./Drivers/DSP/Source/CommonTables/arm_const_structs.o 

C_DEPS += \
./Drivers/DSP/Source/CommonTables/CommonTables.d \
./Drivers/DSP/Source/CommonTables/arm_common_tables.d \
./Drivers/DSP/Source/CommonTables/arm_const_structs.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/DSP/Source/CommonTables/%.o Drivers/DSP/Source/CommonTables/%.su Drivers/DSP/Source/CommonTables/%.cyclo: ../Drivers/DSP/Source/CommonTables/%.c Drivers/DSP/Source/CommonTables/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -D__FPU_PRESENT=1U -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../Core/Inc -I../Drivers/DSP/Include -I../Drivers/DSP/PrivateInclude -I../Drivers/STM32G4xx_HAL_Driver/Inc -I../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-DSP-2f-Source-2f-CommonTables

clean-Drivers-2f-DSP-2f-Source-2f-CommonTables:
	-$(RM) ./Drivers/DSP/Source/CommonTables/CommonTables.cyclo ./Drivers/DSP/Source/CommonTables/CommonTables.d ./Drivers/DSP/Source/CommonTables/CommonTables.o ./Drivers/DSP/Source/CommonTables/CommonTables.su ./Drivers/DSP/Source/CommonTables/arm_common_tables.cyclo ./Drivers/DSP/Source/CommonTables/arm_common_tables.d ./Drivers/DSP/Source/CommonTables/arm_common_tables.o ./Drivers/DSP/Source/CommonTables/arm_common_tables.su ./Drivers/DSP/Source/CommonTables/arm_const_structs.cyclo ./Drivers/DSP/Source/CommonTables/arm_const_structs.d ./Drivers/DSP/Source/CommonTables/arm_const_structs.o ./Drivers/DSP/Source/CommonTables/arm_const_structs.su

.PHONY: clean-Drivers-2f-DSP-2f-Source-2f-CommonTables

