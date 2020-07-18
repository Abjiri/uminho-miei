a=toml2json

$a : $a.y $a.l
	flex $a.l
	yacc -d $a.y
	cc -o $a y.tab.c lex.yy.c -lm

install: $a
	sudo cp $a /usr/local/bin/

clean:
	sudo rm -f $a
	sudo rm -f /usr/local/bin/$a
	sudo rm -f lex.yy.c y.tab.*
