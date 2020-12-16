/* GRUPO 5 */
/* Integrantes: Valentina Lamanna, Micaela Raiter, y Lucila Melamed */
/* Curso K2004 (Jueves TM) */
/* Noviembre 2020 */

#include <stdio.h>
#include <stdlib.h>
#include "scanner.h"

int main()
{
	TOKEN token;

	do {
		token = yylex();
		switch (token) {
		case RESERVADA:
            printf("Token: %s\t\t\t\n", yytext);
			break;
        case OPERADOR:
            printf("Token: '%s'\t\t\t\n", yytext);
			break;
        case PUNCTVALIDO:
            printf("Token: '%s'\t\t\t\n", yytext);
			break;
        case ASIGNACION:
            printf("Token: Asignación \n");
			break;
		case ID:
            printf("Token: %s\t\t\t\tLexema: %s\n", "Identificador", yytext);
			break;
		case CONSTANTE:
            printf("Token: %s\t\t\tLexema: %s\n", "Constante Numerica", yytext);
			break;
		case DESCONOCIDA:
            printf("Error léxico: cadena desconocida: %s\n", yytext);
			break;
        case IDINVALIDO:
            printf("Error léxico: identificador inválido: %s\n", yytext);
			break;
        case CONSTINVALIDA:
            printf("Error léxico: constante inválida: %s\n", yytext);
			break;
		}
	} while (token != FDT);

     printf("Token: Fin de Archivo \n");

	return EXIT_SUCCESS;
}
