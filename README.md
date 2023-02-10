GPM4 NAND Dumper Host
=====================

This program is designed to run bare metal for dumping NAND when GPM4 is running
the bootrom. After NAND and SDRAM initialization, upload program and set up
params and it will dump a number of NAND pages (+spare) to SDRAM, which you can
then read out and combine to form a full NAND dump.

See `convert.map` after `make`ing for addresses needed.
