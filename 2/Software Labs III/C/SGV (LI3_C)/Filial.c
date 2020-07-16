#include <stdlib.h>
#include <string.h>
#include "AVLTrees.h"
#include "Filial.h"
#include "CatProds.h"
#include "CatClis.h"
#define _GNU_SOURCE
#include <string.h>

/*Structs*/
struct pcfil {
	Produto  produto;  	
	double   preco;   
	int      unidades; 
	char     tipo;      
	int      mes;      
};

struct vfil {    
	Cliente cliente;
	AVL prodsc;      
};

struct cat_vfils {
	AVL* fils; 
};


/*Operações sobre PCFils*/
int comparaPCFils (PCFil f1, PCFil f2) {
	return strcmp(getProd(f1->produto),getProd(f2->produto));
}

PCFil criaPCFil (Venda v) {
	PCFil f = malloc(sizeof(struct pcfil));

	f->produto = criaProd(v.produto);
	f->preco = v.preco;
	f->unidades = v.unidades;
	f->tipo = v.tipo;
	f->mes = v.mes;
	return f;
}

void free_PCFil (PCFil f) {
	free_Prod(f->produto);
	free(f);
}


/*Operações sobre VFils*/
int comparaVFils (VFil f1, VFil f2) {
	return strcmp(getCli(f1->cliente),getCli(f2->cliente));
}

VFil criaVFil (char* cliente) {
	VFil f = malloc(sizeof(struct vfil));

	f->cliente = criaCli(cliente);
	f->prodsc = malloc(sizeof(struct avl));
	f->prodsc = NULL;

	return f;
}

void free_VFil (VFil v) {
	free_Cli(v->cliente);
	free_AVL(v->prodsc,'f');
	free(v);
}

VFil inserePCFil (VFil v, PCFil pc) {
	int aum = 0;
	v->prodsc = insereAVL(v->prodsc,pc,&aum,'f');
	return v;
}


/*Operações sobre Cat_VFils*/
Cat_VFils init_CatVFils () {
	Cat_VFils f = malloc(sizeof(struct cat_vfils));
	f->fils = malloc(3* sizeof(struct avl));
	
	for (int i = 0; i < 3; i++)
		f->fils[i] = NULL;
	return f;
}

void free_CatVFils (Cat_VFils f) {
	for (int i = 0; i < 3; i++)
		free_AVL(f->fils[i],'i');
	free(f->fils);
	free(f);
}

Cat_VFils insereVFil (Cat_VFils f, VFil v, PCFil pc, int nf) {
	int aum = 0;
	f->fils[nf] = insereAVLFil(f->fils[nf],v,pc,&aum);
	return f;
}


/*Getters e Setters*/
AVL getAVLFil (Cat_VFils catvf, int i) {
	return catvf->fils[i];
}

AVL getAVLVFil (VFil vfil) {
	return vfil->prodsc;
}

Cliente getCliFil (VFil f) {
	return f->cliente;
}

AVL getProdsFil (VFil f) {
	return f->prodsc;
}

int getMesPCFil (PCFil p) {
	return p->mes;
}

int getUniPCFil (PCFil p) {
	return p->unidades;
}

char* getProdPCFil (PCFil p) {
	return getProd(p->produto);
}

char getTipoPCFil (PCFil p) {
	return p->tipo;
}

Array_Fact insereArrayFact (Array_Fact a, PCFil p, int i, int tipo) {
		if (tipo == 2) {
			a->prod[i] = strdup(getProd(p->produto));
			a->fact[i] = p->preco*p->unidades;
		}
		else if (tipo == 0) {
			a->prod[i]= strdup(getProd(p->produto));
			a->fact[i] = p->preco*p->unidades;
			a->num++;
		}
		if (tipo == 1) a->fact[i] += p->preco*p->unidades;;
	
	return a;
}

int minFact (double* prod) {
	double min = prod[0];
   	int loc = 0;
    for (int c = 1; c < 3; c++) {
        if (prod[c] < min) {
           min = prod[c];
           loc = c;
        }
    }
	return loc;
}

Array_Fact comparaArrayFact (Array_Fact a, PCFil p) {
	for (int i = 0; i < a->num; i++) {
		if (!strcmp(getProd(p->produto),a->prod[i])) 
			return insereArrayFact(a,p,i,1);
	}
	if (a->num < 3) return insereArrayFact(a,p,a->num,0);
	
	double r = p->unidades*p->preco;
	if (r > a->fact[0] || r > a->fact[1] || r > a->fact[2])
		return insereArrayFact(a,p,minFact(a->fact),2);

	return a;
}


/*Query 11*/
char* getCliFil2 (VFil f) {
	return getCli(f->cliente);
}
//Passa os parametros da PCfil para uma estrutua prod uni
Prod_Uni pcfilToProdUni(PCFil f,char* cliente){
	Prod_Uni pu = initProdUni();
	pu->clientes[0]=strdup(cliente);
	pu->prod = strdup(getProd(f->produto));
	pu->uni = f->unidades;
	pu->clis++;

	return pu;
}
