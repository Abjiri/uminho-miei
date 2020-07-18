make: filter.l
	flex filter.l
	gcc -o mkfromtemplate lex.yy.c map.c

clean:
	rm -r mkfromtemplate lex.yy.c