all:
	gcc -c factmain.c
	as factorial.s -o factorial.o
	gcc factorial.o factmain.o -o fact
	
clean:
	rm *.o
	rm fact