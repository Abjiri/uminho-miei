#include <stdlib.h>
#define _GNU_SOURCE
#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include "CatProds.h"

#define NRLETRAS 26 /*nº letras alfabeto*/


/*Structs*/
struct prod {
	char* codProd;
	int flag;
};

struct cat_prods {
	int validos;
	int total;
	AVL* prods;
};


/*Operações sobre produtos*/
Boolean validaProduto (char* produto) {	/* devolve 1 quando o produto é válido*/
	for (int i = 0; i < 2; i++) 
		if (!isupper(produto[i])) return false; 
	for (int i = 2; i < 6; i++) 
		if (!isdigit(produto[i])) return false;
	if (produto[2] == '0') return false;	/* os números só podem ser de 1000 a 9999 logo o primeiro algarismo não pode ser 0*/
	return true;
}

Produto criaProd (char* codProd) {
	Produto p = malloc(sizeof(struct prod));
	p->codProd = strdup(codProd);
	p->flag = 0;
	return p;
}

void free_Prod (Produto p) {
	free(p->codProd);
	free(p);
}

int comparaProds (Produto p1, Produto p2) {
	return strcmp(p1->codProd,p2->codProd);
}


/*Operações sobre Cat_Prods*/
Cat_Prods inicializa_CatProds () {
	Cat_Prods catp = malloc(sizeof(struct cat_prods));
	catp->prods = malloc(NRLETRAS * sizeof(struct avl));
	
	for (int i = 0; i < NRLETRAS; i++)
		catp->prods[i] = NULL;
	catp->validos = 0;
	catp->total = 0;
	return catp;
}

void free_Catp (Cat_Prods catp) {
	for (int i = 0; i < NRLETRAS; i++)
		free_AVL(catp->prods[i],'p');
	free(catp->prods);
	free(catp);
}

Cat_Prods insereProd (Cat_Prods catp, Produto p) {
	int aum = 0, i = p->codProd[0]-'A';
	catp->prods[i] = insereAVL(catp->prods[i],p,&aum,'p');
	catp->validos++;
	return catp;
}

Boolean existeProd (Cat_Prods catp, Produto p) {
	return lookupAVL(catp->prods[p->codProd[0]-'A'],p,'p');
}

Cat_Prods mudaFlagProd (Cat_Prods catp, Produto p, int fil) {
	catp->prods[p->codProd[0] - 'A'] = mudaFlagAVL(catp->prods[p->codProd[0]-'A'],p,'p',fil);
	return catp;
}


/*Getters e setters*/
/*1 - F1, 2 - F2, 3 - F3, 4 - F1+F2, 5 - F1+F3, 6 - F2+F3, 7 - F1+F2+F3*/
Produto setFlagProd (Produto p, int fil) {
	if (p->flag == 0) p->flag = fil;
	else if (fil == 1) {
		if (p->flag == 2) p->flag = 4;
		if (p->flag == 3) p->flag = 5;
		if (p->flag == 6) p->flag = 7;
	}
	else if (fil == 2) {
		if (p->flag == 1) p->flag = 4;
		if (p->flag == 3) p->flag = 6;
		if (p->flag == 5) p->flag = 7;
	}
	else if (fil == 3) {
		if (p->flag == 1) p->flag = 5;
		if (p->flag == 2) p->flag = 6;
		if (p->flag == 4) p->flag = 7;
	}
	return p;
}

Cat_Prods incTotalProds (Cat_Prods catp) {
	catp->total++;
	return catp;
}

AVL getAVLProds (Cat_Prods catp, int i) {
	return catp->prods[i];
}

int getTotalProds (Cat_Prods catp) {
	return catp->total;
}

int getValProds (Cat_Prods catp) {
	return catp->validos;
}

char* getProd (Produto p) {
	return p->codProd;
}

int getFlagP (Produto p) {
	return p->flag;
}

/*Queries*/
int numProdsQ6 (Cat_Prods catp) {
	int a = 0;
	for (int i = 0; i < 26; i++) 
		a = numNuncaComp(a,catp->prods[i],0);
	return a;
}