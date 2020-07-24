nemesis: lex.yy.c y.tab.c
	 gcc -g lex.yy.c y.tab.c -o nemesis

lex.yy.c: y.tab.c nemesis.l
	lex nemesis.l

y.tab.c: nemesis.y
	yacc -d nemesis.y

clean: rm -rf lex.yy.c y.tab.c y.tab.h nemesis nemesis.dSYM

