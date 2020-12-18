/* GRUPO 5 */
/* Integrantes: Valentina Lamanna, Micaela Raiter, y Lucila Melamed */
/* Curso K2004 (Jueves TM) */
/* Noviembre 2020 */

#include <stdio.h>
#include "parser.h"


int main () {
printf("\n--------------------------------");
switch( yyparse() ) {
		case 0: printf("\n\nCompilación terminada con éxito");
			break;		
		case 1: printf("\n\nErrores de compilación");
			break;
		case 2: printf("\n\nNo hay memoria suficiente");
			break;		
		}
printf("\nErrores sintácticos:  %i\t - Errores lexicos:  %i\n", yynerrs, yylexerrs);
printf("--------------------------------\n\n");
return 0;
}

