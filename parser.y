%code top{
#include <stdio.h>
#include "scanner.h" // se tiene que relacionar con scanner.l
}

%code provides {
void yyerror(const char *s);
extern int yylexerrs;
extern int errlex; 	/* Contador de Errores Léxicos */
}

%define api.value.type{char *}

%defines "parser.h" //modifique
%output "parser.c" //modifique
%start programa /* El no terminal que es AXIOMA de la gramatica del TP2 */
%define parse.error verbose /* Mas detalles cuando el Parser encuentre un error en vez de "Syntax Error" */
%union {
	int    num;
	double real;
	char   *str;
}
%token PROGRAMA DECLARAR LEER ESCRIBIR FIN FDT ID CONSTANTE  PUNCTVALIDO ASIGNACION 
%left '+' '-'
%left '*' '/'
%precedence NEGATIVO


%%
programa		: PROGRAMA listaSentencias FIN {if (errlex+yynerrs > 0) YYABORT;else YYACCEPT;};
			;
listaSentencias	: listaSentencias sentencia
			| sentencia
			; 
sentencia		: declaracion 
			| escritura
                       | lectura
			| asignacion
                       | expresion
			;
declaracion		: DECLARAR ID '.' 			        {printf("\declarar %s", ID);}
			; 
escritura		: ESCRIBIR '(' listaExpresiones ')' '.'  	{printf("\nescribir");}
			; 
lectura 		: LEER '(' listaIdentificadores ')' '.' 	{printf("\nleer");}
			;
asignacion		: ID ASIGNACION expresion '.' 	        {printf("\nasignación");}
			;			
listaExpresiones	: listaExpresiones ',' expresion
			| expresion
			;
listaIdentificadores 	: listaIdentificadores ',' ID 
			| ID
			;
expresion              : expresion operadorAditivo termino
			| termino
			| '-' expresion %prec NEGATIVO  		{printf("\ninversión");}
			;
termino		: termino operadorMultiplicativo factor
		        | factor
		        ;
factor			: operadorAditivo cteNumerica 
			| '(' expresion ')'                            {printf("\nparéntesis");}
                       | operadorAditivo ID
			;
cteNumerica            : cteNumerica CONSTANTE
			| CONSTANTE
			;
operadorAditivo        : '+'  			               {printf("\nsuma");}
			| '-' 			                       {printf("\nresta");}
			;
operadorMultiplicativo : '*'    			               {printf("\nmultiplicación");}
			| '/'    			               {printf("\ndivisión");}
			;
%%

//int nerrlex = 0;
//int main() {
//	switch( yyparse() ){
//	case 0:
//		puts("Pertenece al LIC"); return 0;
//	case 1:
//		puts("No pertenece al LIC"); return 1;
//	case 2:
//		puts("Memoria insuficiente"); return 2;
//	}
//	return 0;
//}

/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	printf("línea #%d: %s\n", yylineno, s);
	return;
}
