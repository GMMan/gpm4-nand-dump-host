# Initialization: reboot while ICE mode pin held high, then run
halt
adapter speed 15000
rbp all
# Break on call to GlobalVarInit() in DrvNand_initial(), NAND HAL is ready at this point
bp 0x008055c8 2 hw
reg pc 0x1ff82a84 ;# Break out of ICE mode loop
resume ;# Wait for bp to hit

# Load binary and params
load_image nand_dump_host/convert.bin 0x01fff000
bp 0x01fff0e8 2 hw ;# Set bp for bp() when command finishes
mww 0x01fff110 0x0 ;# Operation: read
mww 0x01fff118 0x0 ;# Buffer pointer
mww 0x01fff11c 0x0 ;# Page number
mww 0x01fff120 4096 ;# Page size
mww 0x01fff124 256 ;# Spare size
mww 0x01fff128 7695 ;# Number of pages to read per command
mww 0x01fff12c 131072 ;# Page number read stops on
reg pc 0x01fff000 ;# Set pc to binary function
resume ;# Let it run till bp()

mww 0x01fff110 2 ;# Operation: erase block
mww 0x01fff11c 1990 ;# Block number
resume ;# Run command
mdw 0x01fff114 ;# Check rc

load_image nand_new_maps/page_126976.bin 0x01e00000 ;# Upload page into buffer
mww 0x01fff110 1 ;# Operation: write page
mww 0x01fff118 0x01e00000 ;# Buffer pointer
mww 0x01fff11c 126976 ;# Page number
mww 0x01fff130 0xff66ffff ;# Spare lo word
mww 0x01fff134 0xffffffff ;# Spare hi word
resume ;# Run command
mdw 0x01fff114 ;# Check rc
