%code top{
#include <stdio.h>
#include "tokens.h" //agregue yo
#include "scanner.h" // se tiene que relacionar con scanner.l
}
%code provides {
void yyerror(const char *s);
extern int nerrlex;
}
%defines "parser.h" //modifique
%output "parser.c" //modifique
%union {
	int    num;
	double real;
	char   *str;
}
%token<str> ID
%token<num> DECIMAL
%token<real> REAL

%code {
char *token_names[] = {"ID", "DECIMAL", "REAL"};
}

%%

todo	: listado {if (nerrlex) YYABORT;} 
listado : cte
	| listado cte
	;
cte	: ID {printf("Token: %s\t\tValor texto: %s\n", token_names[0], $<str>1);}
	| DECIMAL {printf("Token: %s\t\tValor entero: %d\n",
			token_names[1], $DECIMAL);}
	| REAL {printf("Token: %s\t\tValor real: %g\n", 
			token_names[2], $REAL);}
	;
%%

int nerrlex = 0;
int main() {
	switch( yyparse() ){
	case 0:
		puts("Pertenece al LIC"); return 0;
	case 1:
		puts("No pertenece al LIC"); return 1;
	case 2:
		puts("Memoria insuficiente"); return 2;
	}
	return 0;
}
/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	printf("línea #%d: %s\n", yylineno, s);
	return;
}
