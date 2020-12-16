%top{
#include "tokens.h"
}
%option outfile="scanner.c"
%option header-file="scanner.h"
%option nodefault
%option noinput
%option nounput


L                   [[:alpha:]]
D                   [0-9]
LD                  [[:alnum:]]
S                   [[:space:]]
OP                  [\+\-\*/]
PUNCT               [;,\(\)]       
E                   [[:^alnum:]]{-}[[:space:]]{-}[;,\(\)]{-}[\+\-\*/]            
RESERV              programa|declarar|leer|escribir|fin-prog

%%
{RESERV}                            return RESERVADA;
{L}{LD}*                            return ID;
{D}+                                return CONSTANTE;
{OP}                                return OPERADOR;
"<-"                                return ASIGNACION;
{PUNCT}                             return PUNCTVALIDO;
"##".*                              /* NO HACE NADA, ES UN COMENTARIO */
{S}+                                /* ESPACIO */
{D}{LD}+                            return CONSTINVALIDA;
{L}{LD}*{E}+{LD}*                   return IDINVALIDO;
{E}+                                return DESCONOCIDA;


