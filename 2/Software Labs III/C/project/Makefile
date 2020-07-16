CFlags = -O2 -Wall -Wextra -pedantic

EXEC = LI3_GRUPO23

objects = main.o AVLTrees.o CatClis.o \
		  CatProds.o Facturacao.o Filial.o \
		  Navegador.o Queries.o Vendas.o

$(EXEC): $(objects)
	cc -o $(EXEC) $(objects)

main.o : main.c main.h Queries.h CatProds.h CatClis.h Facturacao.h Filial.h
AVLTrees.o : AVLTrees.c AVLTrees.h CatProds.h CatClis.h Facturacao.h Filial.h Vendas.h Navegador.h
CatClis.o : CatClis.c CatClis.h AVLTrees.h
CatProds.o : CatProds.c CatProds.h AVLTrees.h
Facturacao.o : Facturacao.c Facturacao.h AVLTrees.h CatProds.h Vendas.h
Filial.o : Filial.c Filial.h AVLTrees.h CatProds.h CatClis.h Vendas.h
Navegador.o : Navegador.c Navegador.h
Queries.o : Queries.c Queries.h AVLTrees.h CatProds.h CatClis.h Facturacao.h Filial.h Navegador.h main.h
Vendas.o: Vendas.c Vendas.h AVLTrees.h CatProds.h CatClis.h

clean :
	rm -rf *.o $(EXEC)