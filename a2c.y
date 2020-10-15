%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <stdarg.h>
#include <ctype.h>
#include <iostream> 
#define YYSTYPE std::string 
int my_yog(const char* format, ...);
%}


%start linelist
%token MOV MVN MOVK 
%token LDUR STUR
%token SUB ADD
%token EOR EON ORR ORN BIC AND MADD
%token NUM REG LSL16 WZR
%token COMMA LINEEND 
%%
linelist
    : line LINEEND
    | linelist line LINEEND
    ;

line
    : oper right { std::cout<<$1<<"("<<$2<<");"<<std::endl;  } 
    | oper left COMMA right { std::cout<<$1<<"("<<$2<<","<<$4<<");"<<std::endl;  }
    | oper left COMMA right COMMA right { std::cout<<$1<<"("<<$2<<","<<$4<<","<<$6<<");"<<std::endl;  }
    | oper left COMMA right COMMA right COMMA right { std::cout<<$1<<"("<<$2<<","<<$4<<","<<$6<<","<<$8<<");"<<std::endl;  }
    ;

oper    
    : MOV
    | MVN
    | MOVK
    | LDUR
    | STUR
    | SUB
    | ADD
    | EOR
    | EON
    | ORR
    | ORN
    | BIC
    | AND
    | MADD
    ;

left
    : REG { /*std::cout<<"["<<$1<<"]";*/  }
    ;

right
    : REG 
    | NUM
    | LSL16
    | WZR
    ;

%%
int my_yog(const char* format, ...)
{
	int result;
    va_list vp;
    va_start(vp, format);
    result = vprintf(format, vp);
    va_end(vp);
    return result;
}
int main (void) {
	return yyparse ( );
}

void yyerror (char *s) {
    fprintf (stderr, "%s\n", s);
} 