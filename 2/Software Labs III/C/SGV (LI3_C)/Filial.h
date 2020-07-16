#ifndef FILIAL_H
#define FILIAL_H

#include "Vendas.h"

/*Structs*/
typedef struct pcfil* PCFil;
typedef struct vfil* VFil;
typedef struct cat_vfils* Cat_VFils;


/*Operações sobre PCFils*/
int comparaPCFils (PCFil f1, PCFil f2);
PCFil criaPCFil (Venda v);
void free_PCFil (PCFil f);

/*Operações sobre VFils*/
int comparaVFils (VFil f1, VFil f2);
VFil criaVFil (char* cliente);
void free_VFil (VFil v);
VFil inserePCFil (VFil v, PCFil pc);

/*Operações sobre Cat_VFils*/
Cat_VFils init_CatVFils ();
void free_CatVFils (Cat_VFils f);
Cat_VFils insereVFil (Cat_VFils f, VFil v,PCFil pc ,int nf);

/*Getters e Setters*/
AVL getAVLFil (Cat_VFils catvf, int i);
AVL getAVLVFil (VFil vfil);
Cliente getCliFil (VFil f);
AVL getProdsFil (VFil f);
int getMesPCFil (PCFil p);
int getUniPCFil (PCFil p);
char getTipoPCFil (PCFil p);
char* getProdPCFil (PCFil p);
char* getCliFil2 (VFil f);

/*Queries*/
Array_Fact comparaArrayFact(Array_Fact a,PCFil p);
Prod_Uni pcfilToProdUni(PCFil f,char* cliente);

#endif
