%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
%}
%start linelist
%token MOV MVN MOVK LSL16 
%token LDUR STUR
%token SUB ADD
%token EOR EON ORR ORN BIC
%token NUM REG
%token COMMA LINEEND 
%%
linelist
    : line LINEEND
    | linelist line LINEEND
    ;

line
    : MOV REG COMMA REG
    | MOV REG COMMA NUM
    ;
%%
int main (void) {
	return yyparse ( );
}

void yyerror (char *s) {
    fprintf (stderr, "%s\n", s);
} 