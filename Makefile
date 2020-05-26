all: lex.yy.c y.tab.c
	gcc -omain lex.yy.c y.tab.c

lex.yy.c:flex.l y.tab.c
	flex flex.l

y.tab.c:bison.y
	bison -dy bison.y

clean:
	rm y.tab.c lex.yy.c y.tab.h main
