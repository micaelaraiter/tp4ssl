%top{
#include "parser.h"
}

%{
char buffer[200];
int yylexerrs;
%}

%option outfile="scanner.c"
%option header-file="scanner.h"
%option nodefault
%option noinput
%option nounput
%option yylineno

L                   [[:alpha:]]
D                   [0-9]
LD                  [[:alnum:]]
S                   [[:space:]]
PUNCT               [;,\(\)]       
E                   [[:^alnum:]]{-}[[:space:]]{-}[;,\(\)]{-}[\+\-\*/]            


%%
"programa"	                    return PROGRAMA;
"declarar"	                    return DECLARAR;
"leer"		                    return LEER;
"escribir"	                    return ESCRIBIR;
"fin-prog"		             return FIN;
{L}{LD}*                            {yylval = strdup(yytext); return ID;}
{D}+                                {yylval = strdup(yytext); return CONSTANTE;}
"+"		                     return '+';
"-"		                     return '-';
"*"		                     return '*';
"/" 		                     return '/';
"<-"                                return ASIGNACION;
"("		                     return '(';
")"		                     return ')';
{PUNCT}                             return PUNCTVALIDO;
"##".*                              /* NO HACE NADA, ES UN COMENTARIO */
{S}+                                /* ESPACIO */
{D}{LD}+                            {yylexerrs++; sprintf(buffer,"Error Léxico:  Constante inválida: %s",yytext); yyerror(buffer);}
{L}{LD}*{E}+{LD}*                   {yylexerrs++; sprintf(buffer,"Error Léxico:  Identificador inválido: %s", yytext); yyerror(buffer);}
{E}+                                {yylexerrs++; sprintf(buffer,"Error Léxico:  Cadena desconocida: %s", yytext); yyerror(buffer);}


