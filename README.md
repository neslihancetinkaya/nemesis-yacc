# Programming Language Nemesis
make nemesis<br/>
./nemesis < example.nms

## Group Members
Neslihan Çetinkaya

## Syntax
< line > ::= < statements > | < line > < statements > <br/> 
< statements > ::= < printstatement > | < exitstatement > | < assignmentstatement > | < whilestatement > | < ifelsestatement > | < incdecstatement > | < functionstatement > 
	| < functioncallstatement > <br/>
< exp > ::= < arithmeticexp > | < logicalexp > <br/>
< term > ::= < number > | < identifier > <br/>
< comment > : < singleline comment > | < multiline comment > <br/>

< singleline comment > ::= COMMENT <br/>
< multiline comment > ::= START + < comment > + END  <br/>

< number > ::= [ 0 - 9 ]+ <br/>
< identifier > ::= [ a-zA-Z] <br/>
< boolean > ::= TRUE | FALSE <br/>

< arithmeticexp > ::= < arithmeticexp > PLUS < term > <br/>
	| < arithmeticexp > MINUS < term > <br/>
	| < arithmeticexp > MULTIPLY < term > <br/>
      	| < arithmeticexp > DIVIDE < term > <br/>
      	| < arithmeticexp > MOD < term > <br/>
      	| < term > <br/>
< logicalexp > ::= < logicalexp > AND < boolean > <br/>
	| < logicalexp > OR < boolean > <br/>
	| < logicalexp > EQUAL < boolean > <br/>
	| < logicalexp > NOTEQUAL < boolean > <br/>
	| < arithmeticexp > GREATERTHAN < arithmeticexp > <br/>
	| < arithmeticexp > LESSTHAN < arithmeticexp > <br/>
	| < arithmeticexp > GREATERTHANOREQUAL < arithmeticexp > <br/>
	| < arithmeticexp > LESSTHANOREQUAL < arithmeticexp > <br/>
	| < arithmeticexp > EQUAL < term > <br/>
	| < arithmeticexp > NOTEQUAL < term > <br/>
	| NOT < boolean > <br/>
	| < boolean > <br/>
	
### Statements
< printstatement > ::= PRINT < exp > ; <br/>

< exitstatement > ::= EXIT ; <br/>

< assignmentstatement > ::= < assignment > <br/>
< assignment > ::= < identifier > ASSIGN < exp > <br/>

< whilestatement > ::= < whileexp > { < whilestates > } <br/>
< whileexp > ::= WHILE ( < logicalexp > ) | WHILE ( < identifier > ) <br/>
< whilestates > ::= < sts > | < whilests > | < whilestates > < sts > | < whilestates > < whilests > <br/>
< whilests > ::= < identifier > ASSIGN < sts > <br/>
	| PRINT < sts > <br/>
	| < ifelsestatement > <br/>
	| < whilestatement > <br/>
	| < incdecstatement > <br/>
	| < functioncallstatement > <br/>

< sts > ::= < term > PLUS < term > <br/>
	| < term > MINUS < term > <br/>
	| < term > MULTIPLY < term > <br/>
      	| < term > DIVIDE < term > <br/>
      	| < term > MOD < term > <br/>
      	| < term > GREATERTHAN < term > <br/>
	| < term > LESSTHAN < term > <br/>
	| < term > GREATERTHANOREQUAL < term > <br/>
	| < term > LESSTHANOREQUAL < term > <br/>
	| < term > EQUAL < term > <br/>
	| < term > NOTEQUAL < term > <br/>
	| < boolean > AND < boolean > <br/>
	| < boolean > OR < boolean > <br/>
	| < boolean > EQUAL < boolean > <br/>
	| < boolean > NOTEQUAL < boolean > <br/>
	| INCREASE < identifier > <br/>
	| DECREASE < identifier > <br/>
	| NOT < boolean > <br/>
	| < boolean > <br/>
      	| < term > <br/>

< ifelsestatement > ::= < ifstatement > | < ifstatement > < elsestatement > <br/>

< ifstatement > ::= < ifexp > { < ifstates > } <br/>
< ifexp > ::= IF ( < logicalexp > ) | IF ( < identifier > ) <br/>
< ifstates > ::= < sts > | < ifsts > | < ifstates > < sts > | < ifstates > < ifsts > <br/>
< ifsts > ::= < identifier > ASSIGN < sts > <br/>
	| PRINT < sts > <br/>
	| < ifelsestatement > <br/>
	| < whilestatement > <br/>
	| < incdecstatement > <br/>
	| < functioncallstatement > <br/>

< elsestatement > ::= ELSE { < elsestates > } <br/>
< elsestates > ::= < sts > | < elsests > | < elsestates > < sts > | < elsestates > < elsests > <br/>
< elsests > ::= < identifier > ASSIGN < sts > <br/>
	| PRINT < sts > <br/>
	| < ifelsestatement > <br/>
	| < whilestatement > <br/>
	| < incdecstatement > <br/>
	| < functioncallstatement > <br/>

< incdecstatement > ::= INCREASE < identifier > ; | DECREASE < identifier > ; <br/>

< functionstatement > ::= < funcexp > { < functionstates > } <br/>
< funcexp > ::= FUNCTION < identifier > ( ) <br/>
< functionstates > ::= < sts > | < functionsts > | < functionstates > < sts > | < functionstates > < functionsts > <br/>
< functionsts > ::= < identifier > ASSIGN < sts > <br/>
	| PRINT < sts > <br/>
	| < ifelsestatement > <br/>
	| < whilestatement > <br/>
	| < incdecstatement > <br/>
	| < functioncallstatement > <br/>

< functioncallstatement > ::= < identifier > ( ) ; <br/>
	
### Words
< words > ::= ASSIGN | PLUS | MINUS | DIVIDE | MULTIPLY | MOD | AND | OR | NOT | GREATERTHAN  <br/>
       | GREATERTHANOREQUAL | LESSTHAN | LESSTHANOREQUAL | EQUAL | NOTEQUAL | TRUE | FALSE | COMMENT <br/>
       | START | END | IF | ELSE | WHILE | PRINT | EXIT | INCREASE | DECREASE | FUNCTION

  
## Explanations about the language

The language will be used by kids, for making mathematical operations. <br/>
- ASSIGN -> ASSIGN is a word for assigning an integer to an identifier.
- PLUS -> PLUS is a word for adding two integer.
- MINUS -> MINUS is a word for subtracting two integer.
- DIVIDE -> DIVIDE is a word for dividing two integer.
- MULTIPLY -> MULTIPLY is a word for multiplying two integer.
- MOD -> MOD is a word for making a mod operation.
- AND -> AND is a word for logical and ( ∧ ). 
- OR -> OR is a word for logical or ( ∨ ).
- NOT -> NOT is a word for logical not ( ! ).
- IF -> IF is a word to make an if conditional.
- ELSE -> ELSE is a word to make an else conditional, optional.
- GREATERTHAN -> GREATERTHAN is a word for comparing two integer if one of them is greater than the other one.
- GREATERTHANOREQUAL -> GREATERTHANOREQUAL is a word for comparing two integer if one of them is greater than or equal to other one.
- LESSTHAN -> LESSTHAN is a word for comparing two integer if one of them is less than the other one.
- LESSTHANOREQUAL -> LESSTHANOREQUAL is a word for comparing two integer if one of them is less than or equal to other one.
- EQUAL -> EQUAL is a word for comparing two integer or boolean if they are equal.
- NOTEQUAL -> NOTEQUAL is a word for comparing two integer or boolean if they are equal.
- TRUE -> TRUE is a boolean value which represents 1.
- FALSE -> FALSE is a boolean value which represents 0.
- COMMENT -> COMMENT is a word for singleline comment.
- START -> START is a word for multiline comment.
- END -> END is a word for ending multiline comment.
- WHILE -> WHILE is a word to make a while loop.
- PRINT -> PRINT is a word for printing.
- EXIT -> EXIT is a word to end the program.
- INCREASE -> INCREASE is a word to increase the value of an identifier.
- DECREASE -> DECREASE is a word to decrease the value of an identifier.
- FUNCTION -> FUNCTION is a word to create a function.
