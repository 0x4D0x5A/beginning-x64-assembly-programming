#makefile for Jump.asm
Jump: Jump.o
	gcc -o Jump Jump.o -no-pie
Jump.o: Jump.asm
	nasm -f elf64 -g -F dwarf Jump.asm -l Jump.lst
