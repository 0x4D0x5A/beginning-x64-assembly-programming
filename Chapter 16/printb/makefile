printb: printb.o 
	gcc -g -o printb printb.o -no-pie
printb.o: printb.asm
	nasm -f elf64 -g -F dwarf printb.asm -l printb.lst
