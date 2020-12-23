/* GRUPO 5 */
/* Integrantes: Valentina Lamanna, Micaela Raiter, y Lucila Melamed */
/* Curso K2004 (Jueves TM) */
/* Diciembre 2020 */

#include <stdio.h>
#include "parser.h"


int main () {
if(yyparse()) {
        printf("Errores de compilación\n");
    } else {
        printf("Compilación realizada con éxito\n");
    }
    printf("Errores sintácticos: %d  -  Errores léxicos: %d\n", yynerrs, yylexerrs);
}

