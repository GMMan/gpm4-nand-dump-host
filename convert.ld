ENTRY(main)
SECTIONS
{
    . = 0x01fff000;
    .text : { *(.text) }
    .rodata : { *(.rodata) }
    .data : { *(.data) }
    .bss : { *(.bss) }
}

Nand_ReadPhyPage = 0x807028;
Nand_WritePhyPage = 0x807610;
Nand_ErasePhyBlock = 0x806540;
nand_spare_buf = 0x81bf2c;
SpareFlagL = 0x81af30;
SpareFlagH = 0x81af28;
