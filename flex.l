%{
#include <stdlib.h>
void yyerror(char *);
#include "y.tab.h"

%}


%%

[0-9]+  {
          yylval = atoi(yytext);
          return INT;
        }
[(]     {
          return PE;
        }
[)]     {
          return PD;
        }
[+]     {
          return SOMA;
        }
[*]     {
          return MUL;
        }
[\^]	{
	  return EXP;
	}
[/]     {
          return DIV;
        }
\n      {
         return EOL;
       }
[ \t]+ ;

.     {yyerror("Token nao reconhecido!\n");}

%%

int yywrap() {
  return 1;
}
