################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/cmsismodule.c \
../Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/fftinit.c 

OBJS += \
./Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/cmsismodule.o \
./Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/fftinit.o 

C_DEPS += \
./Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/cmsismodule.d \
./Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/fftinit.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/%.o Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/%.su Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/%.cyclo: ../Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/%.c Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -D__FPU_PRESENT=1U -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../Core/Inc -I../Drivers/DSP/Include -I../Drivers/DSP/PrivateInclude -I../Drivers/STM32G4xx_HAL_Driver/Inc -I../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-DSP-2f-PythonWrapper-2f-cmsisdsp_pkg-2f-src

clean-Drivers-2f-DSP-2f-PythonWrapper-2f-cmsisdsp_pkg-2f-src:
	-$(RM) ./Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/cmsismodule.cyclo ./Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/cmsismodule.d ./Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/cmsismodule.o ./Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/cmsismodule.su ./Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/fftinit.cyclo ./Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/fftinit.d ./Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/fftinit.o ./Drivers/DSP/PythonWrapper/cmsisdsp_pkg/src/fftinit.su

.PHONY: clean-Drivers-2f-DSP-2f-PythonWrapper-2f-cmsisdsp_pkg-2f-src

