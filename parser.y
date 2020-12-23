%code top{
#include <stdio.h>
#include "scanner.h" // se tiene que relacionar con scanner.l
}

%code provides {
void yyerror(const char *s);
extern int yylexerrs; /* Contador de Errores Léxicos */
extern int yynerrs; /* Contador de Errores Semanticos */
}

%defines "parser.h" //modifique
%output "parser.c" //modifique


%define api.value.type{char *}
%define parse.error verbose /* Mas detalles cuando el Parser encuentre un error en vez de "Syntax Error" */

%token  PROGRAMA DECLARAR LEER ESCRIBIR FIN ID CONSTANTE PUNCTVALIDO ASIGNACION
%left '+' '-'
%left '*' '/'
%precedence NEGATIVO


%%

programa		: PROGRAMA listaSentencias FIN { if (yynerrs || yylexerrs) YYABORT;}
			;
listaSentencias	: listaSentencias sentencia
			| sentencia
			; 
sentencia		: declaracion 
			| escritura
                       | lectura
			| asignacion
                       | expresion
                       | error ';'
			;
declaracion		: DECLARAR ID ';' 			        {printf("\ndeclarar %s", $ID);}
			| error ';'
			; 
escritura		: ESCRIBIR '(' listaExpresiones ')' ';'  	{printf("\nescribir");}
			| error ';'
			; 
lectura 		: LEER '(' listaIdentificadores ')' ';' 	{printf("\nleer");}
			| error ';'
			;
asignacion		: ID ASIGNACION expresion ';' 	        {printf("\nasignación");}
			| error ';'
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
operadorMultiplicativo : '*'    			               {printf("\nmultiplicación\n");}
			| '/'    			               {printf("\ndivisión");}
			;
%%

//int nerrlex = 0;
//int yylexerrs = 0;
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
int yylexerrs = 0;
void yyerror(const char *s){
	printf("línea #%d: %s\n", yylineno, s);
	return;
}
