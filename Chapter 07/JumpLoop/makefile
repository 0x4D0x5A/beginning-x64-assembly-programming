#makefile for JumpLoop.asm
JumpLoop: JumpLoop.o
	gcc -o JumpLoop JumpLoop.o -no-pie
JumpLoop.o: JumpLoop.asm
	nasm -f elf64 -g -F dwarf JumpLoop.asm -l JumpLoop.lst
