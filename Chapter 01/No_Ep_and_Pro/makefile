#makefile for No_Ep_and_Pro.asm
No_Ep_and_Pro: No_Ep_and_Pro.o
	gcc -o No_Ep_and_Pro No_Ep_and_Pro.o -no-pie
No_Ep_and_Pro.o: No_Ep_and_Pro.asm
	nasm -f elf64 -g -F dwarf No_Ep_and_Pro.asm -l No_Ep_and_Pro.lst
