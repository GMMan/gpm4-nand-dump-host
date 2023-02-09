ENTRY(main)
SECTIONS
{
    . = 0x01fff000;
    .text : { *(.text) }
    .rodata : { *(.rodata) }
    .data : { *(.data) }
    .bss : { *(.bss) }
}

Nand_ReadPhyPage = 0x1ff80c98;
spare_buf_ptr = 0x200000d0;
