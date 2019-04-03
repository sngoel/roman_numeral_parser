%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "p1.tab.h"

void yyerror(const char* s);
%}

%%
I{4,} { yyerror("syntax error"); }
X{4,} { yyerror("syntax error"); }
C{4,} { yyerror("syntax error"); }
IVI{1,} { yyerror("syntax error"); }
IXI{1,} { yyerror("syntax error"); }
XLX{1,} { yyerror("syntax error"); }
XCX{1,} { yyerror("syntax error"); }
"IV" { yylval = 4; return NUM;  }
"IX" { yylval =  9; return NUM; }
"XL" { yylval = 40; return NUM; }
"XC" { yylval = 90; return NUM; }
"I" { yylval  =  1;return NUM; }
"V" { yylval =  5; return NUM;}
"X" { yylval =  10; return NUM; }
"L" { yylval =  50;return NUM; }
"C" { yylval =  100; return NUM; }
"Z" { yylval =  0; return NUM; }
"{" { return LPARENTHESIS; }
"}"	{ return RPARENTHESIS; }
"*" { return MULTIPLY; }
"/"	{ return DIVIDE; }
"+"	{ return ADD; }
"-"	{ return SUBTRACT; }

\n  { return EOL; }
.	{ }
%%