#ifndef CATALOGOS_H
#define CATALOGOS_H

#include "CatProds.h"
#include "CatClis.h"
#include "Facturacao.h"
#include "Filial.h"

#define STRP 8 
#define STRC 7 
#define STRV 32
#define NRLETRAS 26 /*nº letras alfabeto*/
#define NRMESES 12

#define FILEP "Ficheiros/Produtos.txt"
#define FILEC "Ficheiros/Clientes.txt"
#define FILEV "Ficheiros/Vendas_1M.txt"

typedef struct sgv* SGV;

struct sgv {
	Cat_Prods catp;
	Cat_Clis catc;
	Cat_VFacts catvfact;
	Cat_VFils catvfil;
};

SGV init_SGV ();
void free_SGV (SGV sgv);
SGV lerFicheiros ();

#endif