// printb.c

#include <stdio.h>

void printb(long long n){ // n = rdi
	long long s,c;	
	for (c = 63; c >= 0; c--) // iterates 64 times, because its 64 bit
  	{
		s = n >> c;	// 
		// space after every 8th bit
 		if ((c+1) % 8 == 0) printf(" "); // check if its the last bit in a byte (8th bit) if yes, print space

		if (s & 1)	// if bit is 1 print 1 else print 0
      			printf("1");
    		else
      			printf("0");
	}	
	printf("\n");
}
