#Make file sem a flag -ll pois assim funcionou no meu computador. Com gera o seguinte:
#	gcc -omain lex.yy.c y.tab.c -ll
#	/usr/bin/ld: cannot find -ll
#	collect2: error: ld returned 1 exit status
#	make: *** [Makefile:8: ll] Error 1
#
#Para compilar com -ll use make ll

all: lex.yy.c y.tab.c
	gcc -omain lex.yy.c y.tab.c -lfl

ll: lex.yy.c y.tab.c
	gcc -omain lex.yy.c y.tab.c -ll

lex.yy.c:flex.l y.tab.c
	flex flex.l

y.tab.c:bison.y
	bison -dy bison.y

clean:
	rm y.tab.c lex.yy.c y.tab.h main
