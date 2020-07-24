%{
#include "y.tab.h"
void yyerror (char *s);
int yylex();
%}
%%
"PRINT"	{return print;}
"EXIT"		{return exit_command;}
"PLUS"		{return plus;}
"MINUS"	{return minus;}
"MULTIPLY"	{return multiply;}
"DIVIDE"	{return divide;}
"MOD"		{return mod;}
"ASSIGN"	{return assign;}
"AND"		{return and;}
"OR"		{return or;}
"NOT"		{return not;}
"TRUE"		{return TRU;}
"FALSE"	{return FALS;}
"GREATERTHAN"	{return gt;}
"LESSTHAN"	{return lt;}
"LESSTHANOREQUAL" {return lte;}
"GREATERTHANOREQUAL" {return gte;}
"EQUAL"	{return eq;}
"NOTEQUAL"	{return neq;}
"WHILE"	{return whil;}
"INCREMENT"	{return inc;}
"DECREMENT"	{return dec;}
"IF"		{return iff;}
"ELSE"		{return elsee;}
"FUNCTION"	{return func;}
START(.*\n)*.*END ;
COMMENT(.*) ;
[a-zA-Z]	{yylval.id = yytext[0]; return identifier;}
[0-9]+		{yylval.num = atoi(yytext); return number;}

[ \t\n]		;
[-+=;]		{return yytext[0];}
"("        	{return *yytext;}
")"      	{return *yytext;}
"{"        	{return *yytext;}
"}"      	{return *yytext;}
.		{ECHO; yyerror ("unexpected character");}

%%
int yywrap (void) {return 1;}

