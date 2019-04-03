%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}


%token NUM
%token LPARENTHESIS RPARENTHESIS
%token MULTIPLY DIVIDE ADD SUBTRACT
%token EOL

%%

calclist:  {}
	| calclist expr EOL { printf("Result: %d\n", $2); }
;

expr: factor
	| expr ADD factor { $$ = $1 + $3; }
	| expr SUBTRACT factor { $$ = $1 - $3; }
;

factor: parenthesis
	| factor MULTIPLY parenthesis { $$ = $1 * $3; }
	| factor DIVIDE parenthesis { $$ = $1 / $3; }
;

parenthesis: value
	| LPARENTHESIS expr RPARENTHESIS { $$ = $2; }
;

value: NUM
 	| value NUM   { $$ = $$ + $2;  }
;

%%

int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}