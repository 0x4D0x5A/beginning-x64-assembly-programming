#makefile for BetterLoop.asm
BetterLoop: BetterLoop.o
	gcc -o BetterLoop BetterLoop.o -no-pie
BetterLoop.o: BetterLoop.asm
	nasm -f elf64 -g -F dwarf BetterLoop.asm -l BetterLoop.lst
