%{
    #include <stdio.h>
    #include "y.tab.h"
    void yyerror (char *s);
    int yylex();
%}
D           [0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
%%
"MOV"       { printf("MOV "); return(MOV); }
"MVN"       { printf("MVN "); return(MVN); }
"MOVK"      { printf("MOVK "); return(MOVK); }

"LDUR"      { printf("LDUR "); return(LDUR); }
"STUR"      { printf("STUR "); return(STUR); }

"SUB"      { printf("SUB "); return(SUB); }
"ADD"      { printf("ADD "); return(ADD); }

"EOR"      { printf("EOR "); return(EOR); }
"EON"      { printf("EON "); return(EON); }
"ORR"      { printf("ORR "); return(ORR); }
"ORN"      { printf("ORN "); return(ORN); }
"BIC"      { printf("BIC "); return(BIC); }


LSL#16      { printf("%s ",yytext); return(LSL16);}

#(0[xX]{H}+)  { printf("%s ",yytext); return(NUM); }
#{D}+       { printf("%s ",yytext); return(NUM); }


[WX]{D}{D}?   { printf("%s ",yytext); return(REG); }
[,]         { printf(", "); return(COMMA);}
[\n]        { printf("lineend\n"); return(LINEEND); }
.           { printf("*");/* none */}
%%

int yywrap(void)
{
	return 1;
}

// int main(){
//     yylex();
//     return 0;
// }