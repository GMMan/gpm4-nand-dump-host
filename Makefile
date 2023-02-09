BINPATH	?= /c/projects/shared/arm-gnu-toolchain-12.2.rel1-mingw-w64-i686-arm-none-eabi/bin

CC	:= ${BINPATH}/arm-none-eabi-gcc
CFLAGS	+= -g -gdwarf-2 -mcpu=cortex-m4 -mfloat-abi=hard -ffreestanding

LD	:= ${BINPATH}/arm-none-eabi-ld
OBJCOPY	:= ${BINPATH}/arm-none-eabi-objcopy

OBJDIR	= obj


.PHONY: all clean

all: convert.bin

%.bin: $(OBJDIR)/%.elf
		$(OBJCOPY) -O binary $< $@

$(OBJDIR)/convert.elf: convert.ld $(OBJDIR)/convert.o
		$(LD) -Map=convert.map -T convert.ld $(OBJDIR)/convert.o -o $@

$(OBJDIR)/%.o: %.S
		$(CC) -o $@ $(CFLAGS) -c $<

$(OBJDIR)/%.o: %.c
		$(CC) -o $@ $(CFLAGS) -c $<

clean:
		$(RM) $(OBJDIR)/* *.bin *.map
