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
