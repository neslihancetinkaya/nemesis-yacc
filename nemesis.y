%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
int symbols[52];
int symbolVal(char symbol);
int val_1 = 0; //val for while statements
int val_2 = 0; //val for if statements
int val_3 = 0; //val for else statements
int val_4 = 0; //val for function statements
int ifval = 1;
int whileval = 1;
int funcval = 0;
void functionCall(char symbol);
void functionExp(char symbol);
void updateSymbolVal(char symbol, int val);
%}

%union {int num; char id;}         /* Yacc definitions */
%start line
%token print
%token exit_command
%token <num> number
%token <id> identifier
%token assign
%token plus minus multiply divide mod
%token and or not TRU FALS gt lt lte gte eq neq
%token whil inc dec iff elsee func
%type <num> line exp arithmeticexp logicalexp term boolean statements 
%type <num> printstatement exitstatement assignmentstatement 
%type <num> functionstatement functioncallstatement functionstates functionsts funcexp
%type <num> whilestatement whileexp whilests whilestates
%type <num> ifelsestatement ifstatement ifexp ifsts elsestatement elsests sts incdecstatement ifstates
%type <id> assignment


%%

/* descriptions of expected inputs     corresponding actions (in C) */

line		: statements		
		| line statements		
	;

statements	: printstatement
		| exitstatement
		| assignmentstatement
		| whilestatement
		| ifelsestatement
		| incdecstatement
		| functionstatement
		| functioncallstatement
	;
	
printstatement	: print exp ';'		{printf("Printing %d\n", $2);}
		;
	;
	
exitstatement	: exit_command ';'		{exit(EXIT_SUCCESS);}
		;
	;
	
assignmentstatement : assignment ';'		{;}
		;
	;
	
whilestatement	: whileexp '{' whilestates '}' {while(whileval == 1) $$ = val_1;}
	;
	
ifelsestatement : ifstatement 
		| ifstatement elsestatement
	;	

incdecstatement : inc identifier ';'		{updateSymbolVal($2,symbolVal($2) + 1);}
		| dec identifier ';'		{updateSymbolVal($2,symbolVal($2) - 1);}
	;
	
functionstatement : funcexp '{' functionstates '}' {if(funcval == 1) $$ = val_4;}
		;
	;
	
funcexp	: func identifier '(' ')' {functionExp($2);}
		;
	;
	
functioncallstatement : identifier '(' ')' ';' {functionCall($1);}
	;	

assignment	: identifier assign exp  		{ updateSymbolVal($1,$3); }
			;	
	;

exp		: arithmeticexp			{$$ = $1;}
		| logicalexp				{$$ = $1;}
	;
	
arithmeticexp	: arithmeticexp plus term		{$$ = $1 + $3;}
       	| arithmeticexp minus term		{$$ = $1 - $3;}
       	| arithmeticexp multiply term		{$$ = $1 * $3;}
       	| arithmeticexp divide term		{$$ = $1 / $3;}
       	| arithmeticexp mod term		{$$ = $1 % $3;} 
       	| term                 		{$$ = $1;}       	
       ;
       
logicalexp	: logicalexp and boolean			{$$ = $1 && $3;}
       	| logicalexp or boolean			{$$ = $1 || $3;}  
		| arithmeticexp gt arithmeticexp		{$$ = $1 > $3 ? 1 : 0;}    	
       	| arithmeticexp lt arithmeticexp		{$$ = $1 < $3 ? 1 : 0;}
       	| arithmeticexp gte arithmeticexp		{$$ = $1 >= $3 ? 1 : 0;}
       	| arithmeticexp lte arithmeticexp		{$$ = $1 <= $3 ? 1 : 0;}
       	| logicalexp eq boolean			{$$ = $1 == $3 ? 1 : 0;}
       	| logicalexp neq boolean			{$$ = $1 != $3 ? 1 : 0;}
       	| arithmeticexp eq term			{$$ = $1 == $3 ? 1 : 0;}
       	| arithmeticexp neq term			{$$ = $1 != $3 ? 1 : 0;}
       	| not boolean					{$$ = !$2;} 
       	| boolean                			{$$ = $1;}
       ; 

whileexp	: whil '(' logicalexp ')'  	{whileval = $3;}
		| whil '(' identifier ')'  	{whileval = symbolVal($3);}
	; 

whilestates	: sts
		| whilests
		| whilestates sts
		| whilestates whilests
	;
	
whilests	: identifier assign sts 	{while(whileval == 1) updateSymbolVal($1,val_1);}
		| print sts 			{while(whileval == 1) printf("Printing %d\n",val_1);}
		| ifelsestatement 		{;}
		| whilestatement 		{;}
		| incdecstatement 		{;}
		| functioncallstatement	{;}
	;
	
ifstatement	: ifexp '{' ifstates '}' 	{if(ifval == 1) $$ = val_2;}
		;
	;

ifexp		: iff '(' logicalexp ')'  	{ifval = $3;}
		| iff '(' identifier ')'  	{ifval = symbolVal($3);}
	;
	
ifstates	: sts
		| ifsts
		| ifstates sts
		| ifstates ifsts
	;
	
ifsts		: identifier assign sts 	{if(ifval == 1) updateSymbolVal($1,val_2);}
		| print sts 			{if(ifval == 1) printf("Printing %d\n",val_2);}
		| ifelsestatement 		{;}
		| whilestatement 		{;}
		| incdecstatement 		{;}
		| functioncallstatement	{;}
	;
	
elsestatement	: elsee '{' elsestates '}'	{if(ifval == 0) $$ = val_3;}
		;
	;
	
elsestates	: sts
		| elsests
		| elsestates sts
		| elsestates elsests
	;	
	
elsests	: identifier assign sts 	{if(ifval == 0) updateSymbolVal($1,val_3);}
		| print sts 			{if(ifval == 0) printf("Printing %d\n",val_3);}
		| ifelsestatement 		{;}
		| whilestatement 		{;}
		| incdecstatement 		{;}
		| functioncallstatement	{;}
	;
	
functionstates : sts
		| functionsts
		| functionstates sts
		| functionstates functionsts
	;
	
functionsts	: identifier assign sts 	{if(funcval == 1) updateSymbolVal($1,val_4);}
		| print sts 			{if(funcval == 1) printf("Printing %d\n",val_4);}
		| ifelsestatement 		{;}
		| whilestatement 		{;}
		| incdecstatement 		{;}
		| functioncallstatement	{;}
	;
		
sts		: term plus term ';' 		{val_1 = $1 + $3; val_2 = $1 + $3; val_3 = $1 + $3; val_4 = $1 + $3;}
		| term minus term ';' 		{val_1 = $1 - $3; val_2 = $1 - $3; val_3 = $1 - $3; val_4 = $1 - $3;}
		| term multiply term ';' 	{val_1 = $1 * $3; val_2 = $1 * $3; val_3 = $1 * $3; val_4 = $1 * $3;} 
		| term divide term ';' 	{val_1 = $1 / $3; val_2 = $1 / $3; val_3 = $1 / $3; val_4 = $1 / $3;}
		| term mod term ';' 		{val_1 = $1 % $3; val_2 = $1 % $3; val_3 = $1 % $3; val_4 = $1 % $3;}
		| boolean and boolean ';' 	{val_1 = $1 && $3; val_2 = $1 && $3; val_3 = $1 && $3; val_4 = $1 && $3;}
		| boolean or boolean ';' 	{val_1 = $1 || $3; val_2 = $1 || $3; val_3 = $1 || $3; val_4 = $1 || $3;}
		| term gt term ';' 		{val_1 = $1 > $3 ? 1 : 0; val_2 = $1 > $3 ? 1 : 0; val_3 = $1 > $3 ? 1 : 0; val_4 = $1 > $3 ? 1 : 0;}
		| term lt term ';' 		{val_1 = $1 < $3 ? 1 : 0; val_2 = $1 < $3 ? 1 : 0; val_3 = $1 < $3 ? 1 : 0; val_4 = $1 < $3 ? 1 : 0;}	
		| term gte term ';' 		{val_1 = $1 >= $3 ? 1 : 0; val_2 = $1 >= $3 ? 1 : 0; val_3 = $1 >= $3 ? 1 : 0; val_4 = $1 >= $3 ? 1 : 0;}	
		| term lte term ';' 		{val_1 = $1 <= $3 ? 1 : 0; val_2 = $1 <= $3 ? 1 : 0; val_3 = $1 <= $3 ? 1 : 0; val_4 = $1 <= $3 ? 1 : 0;}
		| term eq term ';' 		{val_1 = $1 == $3 ? 1 : 0; val_2 = $1 == $3 ? 1 : 0; val_3 = $1 == $3 ? 1 : 0; val_4 = $1 == $3 ? 1 : 0;}
		| term neq term ';' 		{val_1 = $1 != $3 ? 1 : 0; val_2 = $1 != $3 ? 1 : 0; val_3 = $1 != $3 ? 1 : 0; val_4 = $1 != $3 ? 1 : 0;}
		| boolean eq boolean ';' 	{val_1 = $1 == $3 ? 1 : 0; val_2 = $1 == $3 ? 1 : 0; val_3 = $1 == $3 ? 1 : 0; val_4 = $1 == $3 ? 1 : 0;}
		| boolean neq boolean ';' 	{val_1 = $1 != $3 ? 1 : 0; val_2 = $1 != $3 ? 1 : 0; val_3 = $1 != $3 ? 1 : 0; val_4 = $1 != $3 ? 1 : 0;}
		| inc identifier ';' 		{val_1 = symbolVal($2) + 1; val_2 = symbolVal($2) + 1; val_3 = symbolVal($2) + 1; val_4 = symbolVal($2) + 1;}
		| dec identifier ';' 		{val_1 = symbolVal($2) - 1; val_2 = symbolVal($2) - 1; val_3 = symbolVal($2) - 1; val_4 = symbolVal($2) - 1;}
		| not boolean ';' 		{val_1 = !$2; val_2 = !$2; val_3 = !$2; val_4 = !$2;}
		| boolean ';' 			{val_1 = $1; val_2 = $1; val_3 = $1; val_4 = $1;}
		| term ';' 			{val_1 = $1; val_2 = $1; val_3 = $1; val_4 = $1;}
	;     	
    		
boolean	: TRU				{$$ = 1;}
		| FALS				{$$ = 0;}
       ;
       
term   	: number                	{$$ = $1;}
		| identifier			{$$ = symbolVal($1);} 
	;      

%%                     /* C code */
int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 

/* returns the value of a given symbol */
int symbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, int val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}

void functionCall(char symbol)
{
	if(symbolVal(symbol) == -1){
		funcval = 1;
		printf("Function is called.\n");
	}
	else{
		printf("The function is not defined.\n");
	}	
}

void functionExp(char symbol)
{
	if(symbolVal(symbol) == -1){
		printf("The function already exists.\n");
	}
	if(symbolVal(symbol) != -1){
		updateSymbolVal(symbol, -1);	
	}	
}

int main (void) {
	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
