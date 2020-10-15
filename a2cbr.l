%{
    #include <stdio.h>
    #include <stdarg.h>
    #include <iostream>
    #include <string> 
    #define YYSTYPE std::string 
    void yyerror (char *s);
    int yylex();
    int my_log(const char* format, ...);
%}
D           [0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
%%
"MOV"       { my_log("MOV "); std::cout<<"MOV std"<<std::endl;}
"MVN"       { my_log("MVN "); }
"MOVK"      { my_log("MOVK "); }

"LDUR"      { my_log("LDUR "); }
"STUR"      { my_log("STUR "); }

"SUB"      { my_log("SUB ");  }
"ADD"      { my_log("ADD ");  }

"EOR"      { my_log("EOR ");  }
"EON"      { my_log("EON ");  }
"ORR"      { my_log("ORR ");  }
"ORN"      { my_log("ORN ");  }
"BIC"      { my_log("BIC "); }


LSL#16      { my_log("%s ",yytext);}

#(0[xX]{H}+)  { my_log("%s ",yytext); }
#{D}+       { my_log("%s ",yytext); }


[WX]{D}{D}?   { my_log("%s ",yytext); }
[,]         { my_log(", ");}
[\n]        { my_log("\n"); }
.           { /* none my_log("*"); */}
%%

int my_log(const char* format, ...)
{
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

int main(){
    yylex();
    return 0;
}