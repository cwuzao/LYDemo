%{
    #include <stdio.h>
    #include <stdarg.h>
    #include <string> 
    #define YYSTYPE std::string 
    #include "y.tab.h"
    void yyerror (char *s);
    int yylex();
    int my_log(const char* format, ...);
%}
D           [0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
%%
"{L}+.apk:"  { return(APPNAME); }    
"0000{H}+"  { return(ADDR); }    

"B.EQ"      { my_log("B.EQ "); yylval = yytext; return(BEQ); }

"MOV"       { my_log("MOV "); yylval = yytext; return(MOV); }
"MVN"       { my_log("MVN "); yylval = yytext; return(MVN); }
"MOVK"      { my_log("MOVK "); yylval = yytext; return(MOVK); }

"LDUR"      { my_log("LDUR "); yylval = yytext; return(LDUR); }
"STUR"      { my_log("STUR "); yylval = yytext; return(STUR); }

"SUB"      { my_log("SUB "); yylval = yytext; return(SUB); }
"ADD"      { my_log("ADD "); yylval = yytext; return(ADD); }

"EOR"      { my_log("EOR "); yylval = yytext; return(EOR); }
"EON"      { my_log("EON "); yylval = yytext; return(EON); }
"ORR"      { my_log("ORR "); yylval = yytext; return(ORR); }
"ORN"      { my_log("ORN "); yylval = yytext; return(ORN); }
"BIC"      { my_log("BIC "); yylval = yytext; return(BIC); }
"AND"      { my_log("AND "); yylval = yytext; return(AND); }

"MADD"      { my_log("MADD "); yylval = yytext; return(MADD); }


"LSL#16"      { my_log("%s ",yytext); yylval = yytext; return(LSL16);}
"WZR"      { my_log("%s ",yytext); yylval = yytext; return(WZR);}

#0[xX]{H}+  { my_log("%s ",yytext); yylval = yytext; return(NUM); }
#{D}+       { my_log("%s ",yytext); yylval = yytext; return(NUM); }


[WX]{D}{D}?   { my_log("%s ",yytext);  yylval = yytext; return(REG); }
[,]         { my_log(", "); return(COMMA);}
[=]         { my_log("= "); return(EQ);}
[\n]        { my_log("\n"); return(LINEEND); }
.           { /* none my_log("*"); */}
%%

int my_log(const char* format, ...)
{
    return -1;
	int result;
	
    va_list vp;
    va_start(vp, format);
    result = vprintf(format, vp);
    va_end(vp);
    return result;
}

int yywrap(void)
{
	return 1;
}

// int main(){
//     yylex();
//     return 0;
// }