%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);

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
        |PROGRAMA EXPRESSAO EOL {}
        ;


EXPRESSAO:
    //A pilha eh usada para salvar os valores inteiros da minha expressao. Tambem ao subir a arvore eu quero passar o valor do primeiro argumento $1.
    | INT  {$$=$1 ; printf("PUSH %d\n",$1);}

    //Aqui os parenteses sao de maxima precedencia, certificando que a expressao seja resolvida de forma correta. Ao subir a arvore eu passo o valor da expressao resolvida nos parenteses.
    | PE EXPRESSAO PD { $$=$2; }

    //Uma solucao com for para a exponenciacao. Dei POP C (Armazenando o valor do expoente no registrador C) para ignorar o valor do expoente, desnecessario na minha solucao pelo menos na parte dos printf.
    //De resto o registrador C nao eh usado no meu codigo
    //Tambem houve um cuidado com um laco if, para lidar com numeros elevado a 0.
    //Ao subir a arvore eu passo o valor da expressao resolvida.
    | EXPRESSAO EXP EXPRESSAO   {
	if ($3 != 0){
		printf("POP C\n");
		printf("POP A\n");
		for (int i=0; i<$3-1; i++) {
            $$ *= $1 ;
			printf("MUL %d\n",$1);
		}
		printf("PUSH A\n");

	} else {
        $$ = 1;
		printf("POP C\n");
		printf("POP A\n");
		printf("MOV A,1\n");
		printf("PUSH A\n");
	}
	}

    //Aqui eu uso pilha para implementar as operacoes abaixo sempre dando PUSH para salvar o resultado na mesma.
    //A precendencia das operacoes segue a seguinte ordem: MUL,DIV,SOMA
    // Ao subir a arvore eu passo o valor da expressao resolvida.
    | EXPRESSAO MUL EXPRESSAO   {
    $$ = $1 * $3;
	printf("POP A\n");
	printf("POP B\n");
	printf("MUL B\n");
	printf("PUSH A\n");
        }
    | EXPRESSAO DIV EXPRESSAO   {
    $$ = $1 / $3;
	printf("POP B\n");
	printf("POP A\n");
	printf("DIV B\n");
	printf("PUSH A\n");
        }
    | EXPRESSAO SOMA EXPRESSAO  {
    $$ = $1 + $3;
    printf("POP A\n");
	printf("POP B\n");
	printf("ADD A,B\n");
	printf("PUSH A\n");
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
