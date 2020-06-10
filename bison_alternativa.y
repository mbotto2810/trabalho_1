%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);
int flag=0;

%}

%token EXP
%token INT
%token EOL
%token MUL
%token SOMA
%token DIV
%token PD
%token PE
%left SOMA
%left MUL
%left DIV
%left PE
%left EXP

%%

PROGRAMA:
        | PROGRAMA EXPRESSAO EOL {flag=0;}
	;


EXPRESSAO:
    | INT  {
	if (flag==0) {
		flag=1;
		printf("JMP start\n\n");
		printf("MUL:\n");
		printf("\tMOV A,[D]\n");
		printf("\tDEC D\n");
		printf("\tMOV B,[D]\n");
		printf("\tDEC D\n");
		printf("\tMUL B\n");
		printf("\tINC D\n");
		printf("\tMOV [D],A\n");
		printf("\tRET\n\n");

		printf("DIV:\n");
		printf("\tMOV B,[D]\n");
		printf("\tDEC D\n");
		printf("\tMOV A,[D]\n");
		printf("\tDEC D\n");
		printf("\tDIV B\n");
		printf("\tINC D\n");
		printf("\tMOV [D],A\n");
		printf("\tRET\n\n");

		printf("SOMA:\n");
		printf("\tMOV A,[D]\n");
		printf("\tDEC D\n");
		printf("\tMOV B,[D]\n");
		printf("\tDEC D\n");
		printf("\tADD A,B\n");
		printf("\tINC D\n");
		printf("\tMOV [D],A\n");
		printf("\tRET\n\n");

		printf("EXP:\n");
		printf("\tMOV C,[D]\n");
		printf("\tDEC D\n");
		printf("\tMOV A,[D]\n");
		printf("\tDEC D\n");
		printf("\tDEC C\n");
		printf("\tMOV B,A\n");
		printf("\tloop:\n");
		printf("\tMUL B\n");
		printf("\tDEC C\n");
		printf("\tCMP C,0\n");
		printf("\tJNZ loop\n");
		printf("\tINC D\n");
		printf("\tMOV [D],A\n");
		printf("\tRET\n\n");

		printf("EXP0:\n");
		printf("\tMOV C,[D]\n");
		printf("\tDEC D\n");
		printf("\tMOV A,[D]\n");
		printf("\tDEC D\n");
		printf("MOV A,1\n");
		printf("\tINC D\n");
		printf("\tMOV [D],A\n");
		printf("\tRET\n\n");

		printf("start:\n") ;
		printf("\tMOV D,0xDA\n") ;

	}
	printf("\tINC D\n");
	printf("\tMOV [D],%d\n",$1);

    }
    | PE EXPRESSAO PD {}
    | EXPRESSAO EXP EXPRESSAO   {
	if ($3 != 0){
		printf("CALL EXP\n");
	} else {
		printf("CALL EXP0\n");

	}
	}
    | EXPRESSAO MUL EXPRESSAO   {
	printf("\tCALL MUL\n");
        }
    | EXPRESSAO DIV EXPRESSAO   {
	printf("\tCALL DIV\n");
        }
    | EXPRESSAO SOMA EXPRESSAO  {
	printf("\tCALL SOMA\n");
	}
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
  yyparse();
  return 0;
}
