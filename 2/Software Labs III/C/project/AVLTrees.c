#include "AVLTrees.h"
#include "CatProds.h"
#include "CatClis.h"
#include "Facturacao.h"
#include "Filial.h"
#include "Vendas.h"
#include <string.h>
#include <stdlib.h>

/*Funções auxiliares*/

/*Roda a árvore para a esquerda a fim de a balancear*/
AVL rotateL (AVL a) {
	AVL b = a->dir;
	a->dir = b->esq;
	b->esq = a;
	return b;
}

/*Roda a árvore para a direita a fim de a balancear*/
AVL rotateR (AVL a) {
	AVL b = a->esq;
	a->esq = b->dir;
	b->dir = a;
	return b;
}

/*Balanceia a árvore caso esteja desiquilibrada para a esquerda*/
AVL corrigeL (AVL a) {
	if (a->esq->bal == Esq) {
		a = rotateR(a);
		a->bal = Bal;
		a->dir->bal = Bal;
	}
	else if (a->esq->bal == Bal);
	else {
		a->esq = rotateL(a->esq);
		a = rotateR(a);
		switch(a->bal) {
			case Bal:
				a->dir->bal = Bal;
				a->esq->bal = Bal;
				break;
			case Dir:
				a->esq->bal = Esq;
				a->dir->bal = Bal;
				break;
			case Esq:
				a->dir->bal = Dir;
				a->esq->bal = Bal;
				break;
		}
		a->bal = Bal;
	}
	return a;
}

/*Balanceia a árvore caso esteja desiquilibrada para a direita*/
AVL corrigeR (AVL a) {
	if (a->dir->bal == Dir) {
		a = rotateL(a);
		a->bal = Bal;
		a->esq->bal = Bal;
	}
	else if (a->dir->bal == Bal);
	else {
		a->dir = rotateR(a->dir);
		a = rotateL(a);
		switch(a->bal) {
			case Bal:
				a->esq->bal = Bal;
				a->dir->bal = Bal;
				break;
			case Dir:
				a->esq->bal = Esq;
				a->dir->bal = Bal;
				break;
			case Esq:
				a->dir->bal = Dir;
				a->esq->bal = Bal;
				break;
		}
		a->bal = Bal;
	}
	return a;
}


/*Operações sobre AVLs*/

/*Inicializa uma AVL*/
AVL inicializaAVL () {
	AVL a = malloc(sizeof(struct avl));
	a = NULL;
	return a;
}

/*Verifica o tipo do objeto void* a fim de chamar a função de libertação correspondente*/
void escolheFree (void* a, char tipo) {
	if (tipo == 'p') free_Prod(a);
	if (tipo == 'c') free_Cli(a);
	if (tipo == 'a') free_VFact(a);
	if (tipo == 'i') free_VFil(a);
	if (tipo == 'f') free_PCFil(a);
}

/*Libertar a memória alocada por uma AVL*/
void free_AVL (AVL a, char tipo) {
    if (!a) return;
    free_AVL(a->esq,tipo);
    free_AVL(a->dir,tipo);
    escolheFree(a->info,tipo);
    free(a);
}

/*Verifica o tipo dos objetos void* a fim de chamar a função de comparação correta*/
int escolheCompara (void* a, void* str, char tipo) {
	if (tipo == 'p') return comparaProds(str,a);
	if (tipo == 'c') return comparaClis(str,a);
	if (tipo == 'a') return comparaVFacts(str,a);
	if (tipo == 'i') return comparaVFils(str,a);
					 return comparaPCFils(str,a);
}

/*Insere um elemento numa AVL*/
AVL insereAVL (AVL a, void* str, int *aum, char tipo) {
	if (!a) {
		a = malloc(sizeof(struct avl));
		a->info = str;
		a->esq = a->dir = NULL;
		a->bal = Bal;
		*aum = 1;
	}
	else if (escolheCompara(a->info,str,tipo) < 0) {
		a->esq = insereAVL(a->esq,str,aum,tipo);
		if (*aum == 1) {
			if (a->bal == Dir) { a->bal = Bal; *aum = 0; }
			if (a->bal == Bal) a->bal = Esq;
			else { a = corrigeL(a); *aum = 0; }
		}
	}
	else {
		a->dir = insereAVL(a->dir,str,aum,tipo);
		if (*aum == 1) {
			if (a->bal == Esq) { a->bal = Bal; *aum = 0; }
			if (a->bal == Bal) a->bal = Dir;
			else { a = corrigeR(a); *aum = 0; }
		}
	}
	return a;
}

/*Insere um elemento numa AVL do tipo VFil*/
AVL insereAVLFil (AVL a, void* vfil, void* pcfil, int *aum) {
	if (!a) {
		a = malloc(sizeof(struct avl));
		a->info = inserePCFil(vfil,pcfil);
		a->esq = a->dir = NULL;
		a->bal = Bal;
		*aum = 1;
	}	

	else if (!comparaVFils(vfil,a->info))
		a->info = inserePCFil(a->info,pcfil);

	else if (comparaVFils(vfil,a->info) < 0) {
		a->esq = insereAVLFil(a->esq,vfil,pcfil,aum);
		if (*aum == 1) {
			if (a->bal == Dir) { a->bal = Bal; *aum = 0; }
			if (a->bal == Bal) a->bal = Esq;
			else { a = corrigeL(a); *aum = 0; }
		}
	}
	else  {
		a->dir = insereAVLFil(a->dir,vfil,pcfil,aum);
		if (*aum == 1) {
			if (a->bal == Esq) { a->bal = Bal; *aum = 0; }
			if (a->bal == Bal) a->bal = Dir;
			else { a = corrigeR(a); *aum = 0; }
		}
	}
	return a;
}

/*Muda a flag de um produto/cliente de forma a indicar em que filiais foi comprado/comprou*/
AVL mudaFlagAVL (AVL a, void* str, char tipo, int fil) {
	if (!a);

	else if (!escolheCompara(a->info,str,tipo)) { 
		if (tipo == 'p') a->info = setFlagProd(a->info,fil); 
		else a->info = setFlagCli(a->info,fil);
	}

	else if (escolheCompara(a->info,str,tipo) < 0) 
		a->esq = mudaFlagAVL(a->esq,str,tipo,fil);

	else a->dir = mudaFlagAVL(a->dir,str,tipo,fil);

	return a;
}

/*Verifica se um elemento existe numa AVL*/
Boolean lookupAVL (AVL a, void* str, char tipo) {
	if (!a) return false;
	if (!escolheCompara(a->info,str,tipo)) return true;
	if (escolheCompara(a->info,str,tipo) < 0) return lookupAVL(a->esq,str,tipo);
	return lookupAVL(a->dir,str,tipo);
}


/*Query 2*/
/*Insere numa Lista_Strings todos os códigos de produtos da árvore*/
Lista_Strings prodsLetra (Lista_Strings l, AVL p) {
	if (!p);
	else {
		l = prodsLetra(l,p->esq);
		l = insereLista(l,getProd(p->info));
		l = prodsLetra(l,p->dir);
	}
	return l; 
}

/*Query 3*/
/*Percorre uma AVL inserindo na struct do tipo query3 dados relativos 
ao nº de vendas e ao total faturado com um certo produto*/
q3* vendasFatur (q3* f, AVL a, char* p, int n) {
	if (!a);
	else {
		f = vendasFatur(f,a->esq,p,n);
		f = vendasFaturPorTipo(f,a->info,p,n);
		f = vendasFatur(f,a->dir,p,n);
	}
	return f;
}

/*Query 4*/
/*Percorre uma árvore inserindo numa Lista_Strings os códigos 
dos produtos que ninguém comprou globalmente/em cada filial*/
Lista_Strings naoComprados (Lista_Strings l, AVL p, int fil) {
	if (!p);
	else {
		l = naoComprados(l,p->esq,fil);
		int flag = getFlagP(p->info);
		if ((fil == 0 &&  flag == 0)
		 || (fil == 1 && (flag == 2 || flag == 3 || flag == 6))
		 || (fil == 2 && (flag == 1 || flag == 3 || flag == 5))
		 || (fil == 3 && (flag == 1 || flag == 2 || flag == 4)))
			l = insereLista(l,getProd(p->info));
		l = naoComprados(l,p->dir,fil);
	}
	return l; 
}

/*Query 5*/
/*Percorre uma AVL inserindo numa Lista_Strings os códigos dos clientes
que fizeram compras em todas as filiais*/
Lista_Strings clisComuns (Lista_Strings l, AVL a) {
	if (!a);
	else {
		l = clisComuns(l,a->esq);
		if (getFlagC(a->info) == 7)
			l = insereLista(l,getCli(a->info));
		l = clisComuns(l,a->dir);
	}
	return l; 
}

/*Query 6*/
/*Percorre uma AVL contando o número de produtos/clientes
que nunca foram comprados/compraram nada*/
int numNuncaComp (int a, AVL f, int l) {
	if (!f);
	else {
		a = numNuncaComp(a,f->esq,l);

		int flag;
		if (!l) flag = getFlagP(f->info);
		else    flag = getFlagC(f->info);
		if (!flag) a++;
		
		a = numNuncaComp(a,f->dir,l);
	}
	return a; 
}

/*Query 7*/
/*Atualiza a matriz com o número de unidades de produtos 
comprados por um cliente num dado mês, em determinada filial*/
int** atualizaTab (int** tab, AVL prods, int n) {
	if (!prods);
	else {
		tab = atualizaTab(tab,prods->esq,n);

		tab[getMesPCFil(prods->info)-1][n] += getUniPCFil(prods->info); 
			
		tab = atualizaTab(tab,prods->dir,n);
	}
	return tab; 
}

/*Percorre uma AVL de VFils à procura de um dado cliente*/
int** numMesFil (char* cod, int** tab, AVL f, int n) { 
 	if (!f);
	else {
		tab = numMesFil(cod,tab,f->esq,n);

		if (!comparaClis(getCliFil(f->info),criaCli(cod)))
			return atualizaTab(tab,getProdsFil(f->info),n);
		
		tab = numMesFil(cod,tab,f->dir,n);
	}
	return tab; 
}

/*Query 8*/
/*Calcula o total faturado num dado mês*/
double totalVendasAVL (AVL a) {
	double r = 0;
	if (!a);
	else {
		r+=totalVendasAVL(a->esq);
		r+=getFact(a->info);
		r+=totalVendasAVL(a->dir);
	}
	return r;
}

/*Querie9*/
/*Percorre uma AVL ordenada por códigos de produtos em busca de um código 
especificado e, caso o encontre, retorna o tipo da venda desse produto*/
char prodCli (AVL prods, char* cod) {
	char a = 'a';
	if (!prods);
	else {
		a = prodCli(prods->esq,cod);
		if (a != 'a') return a;

		if (!strcmp(getProdPCFil(prods->info),cod)) return getTipoPCFil(prods->info); 
		
		a = prodCli(prods->dir,cod);
		if (a != 'a') return a;
	}
	return a; 
}

/*Percorre uma AVL colocando em posições diferentes de um array de Lista_Strings
os clientes que compraram um dado produto, dependendo do tipo da compra*/
Lista_Strings* clisCompramProd (Lista_Strings* l, AVL f, char* cod) {
	if (!f);
	else {
		l = clisCompramProd(l,f->esq,cod);

		char tipo = prodCli(getProdsFil(f->info),cod);
		if (tipo == 'N') l[0] = insereLista(l[0],getCli(getCliFil(f->info)));
		if (tipo == 'P') l[1] = insereLista(l[1],getCli(getCliFil(f->info)));

		l = clisCompramProd(l,f->dir,cod);
	}
	return l; 
}

/*Query 10*/
/*Inicializa um Array_PU*/
Array_PU init_PU () {
	Array_PU p = malloc(sizeof(struct arr_pu));
	p -> prods = init_Lista();
	p -> unis = malloc(sizeof(int));
	p -> unis[0] = 0;
	p -> num = 0;
	return p;
}

/*Liberta a memória alocada por um Array_PU*/
void free_PU (Array_PU a) {
	freeLista(a->prods);
	free(a->unis);
	free(a);
}

/*Verifica se um código de produto já existe num array de códigos*/
int repetidos (char** prods, char* prod) {
	for (int i = 0; prods[i]; i++)
		if (!strcmp(prods[i],prod)) return i; /*se encontra um repetido, retorna a posição em que se encontra*/
	return -1; /* caso contrário, devolve -1*/
}

/*Insere um elemento num Array_PU, verificando se este
 já possui o código de produto em questão ou não*/
Array_PU inserePU (Array_PU prodsUnis, int uni, char* prod) {
	int x = repetidos(getStringsLista(prodsUnis->prods), prod);
	if (x != -1) /*produto repetido, é só preciso somar as novas unidades*/
		prodsUnis -> unis[x] += uni;
	else {
		prodsUnis->prods = insereLista (prodsUnis -> prods, prod); /*insere no Array de produtos*/
		int* newInts = (int*) realloc(prodsUnis -> unis,(prodsUnis->num+2)*sizeof(int)); /*insere no Array de Unidades*/
		if (!newInts) return prodsUnis;

		newInts[prodsUnis->num++] = uni;
		newInts[prodsUnis->num] = 0;

		prodsUnis -> unis = newInts;
	}
	return prodsUnis;
}

/*Compara um inteiro com o valor máximo que pode assumir*/
int comparaLim (int a, int b) {
	if (b == -1 || a < b) return 1;
	return 0;
}

/*Calcula o índice do maior elemento no array de unidades
 do Array_PU inferior a lim*/
int maxArray (Array_PU p, int lim) {
	int max = 0;
	int ind = 0;
	for (int i = 0; i < p->num; i++) {
		if (max < p->unis[i] && comparaLim(p->unis[i],lim)) {
			max = p->unis[i];
			ind = i;
		}
	}
	return ind;
}

/*Cria uma Lista_Strings com códigos de produto
 ordenada por unidades vendidas através de um Array_PU*/
Lista_Strings ordenarLista (Lista_Strings l, Array_PU prodsUnis) {
	int pos;
	pos = maxArray(prodsUnis,-1);
	l = insereLista(l,getStringsLista(prodsUnis->prods)[pos]);

    for (int j = 0; j < prodsUnis->num-1; j++) {
    	pos = maxArray(prodsUnis,prodsUnis->unis[pos]);
    	l = insereLista(l,getStringsLista(prodsUnis->prods)[pos]); 
	}
	return l;
}

/*Percorre uma AVL ordenada por códigos de produtos 
 inserindo num Array_PU os produtos vendidos num dado mês*/
Array_PU percorreProd (AVL prods, Array_PU prodsUnis, int m) {
	if (!prods);
	else {
		prodsUnis = percorreProd(prods->esq,prodsUnis,m);

		if (getMesPCFil(prods->info) == m)
			prodsUnis = inserePU(prodsUnis,getUniPCFil(prods->info),getProdPCFil(prods->info));

		prodsUnis = percorreProd(prods->dir,prodsUnis,m);
	}
	return prodsUnis; 
}

/*Percorre uma AVL ordenada por códigos de clientes em busca de um determinado cliente*/
Array_PU percorreCli (AVL f, Array_PU prodsUnis, char* cod, int m) {
	if (!f);
	else {
		prodsUnis = percorreCli(f->esq,prodsUnis,cod,m);

		if (!comparaClis(getCliFil(f->info),criaCli(cod)))
			prodsUnis = percorreProd(getProdsFil(f->info),prodsUnis,m);

		prodsUnis = percorreCli(f->dir,prodsUnis,cod,m);
	}
	return prodsUnis; 
}


/*Query 11*/
/*Inicializa sutrct Array Prod*/
Array_Prod initArrP(int N){
	Array_Prod l = malloc(sizeof(struct arr_prod));
	l->prod = malloc(N*sizeof(char*));
	l->uni = malloc(N*sizeof(int));
	l->clis = malloc(N*sizeof(int));
	for (int i = 0; i < N; ++i) {
		l->uni[i] = 0;
		l->prod[i] = "Z";
		l->clis[i] = 0;
	}
	l->num = 0;
	return l;
}

void freeArrayProd(Array_Prod l){
	for (int i = 0; i < l->num; i++){
		free(l->prod[i]);
		//free(l->uni[i]);
		//free(l->clis[i]);
	}
	free(l->prod);
	free(l->uni);
	free(l->clis);
	free(l);
}
/*inicializa struct Prod Uni*/
Prod_Uni initProdUni(){
	Prod_Uni l = malloc(sizeof(struct prod_uni));
	l->clientes = malloc(20*sizeof(char*));
	for (int i = 0; i < 20; ++i)
		l->clientes[i]="";

	l->prod = malloc(sizeof(char*));
	l->prod = "";
	l->uni = 0;
	l->clis = 0;
	return l;
}

/*Compara dois prod unis*/
int comparaProdUni(Prod_Uni p1,Prod_Uni p2){
	return strcmp(p1->prod,p2->prod);
}
/*Verifica se o produto foi comprado pelo mesmo cliente*/
int existeCliente(Prod_Uni pu,Prod_Uni f){
	for (int i = 0; i < pu->clis; ++i)
	{
		if(strcmp(pu->clientes[0],f->clientes[0])) return 1;
	}
return 0;
}

/*travessia avl da filial, cliente a cliente*/
AVL travessiaQ11Cli (AVL a, AVL f) { //filial n 
 	if (!f);
	else {
		a = travessiaQ11Cli(a,f->esq);

		a = travessiaQ11Prod(a,getAVLVFil(f->info),getCliFil2(f->info)); //encontramos o nodo desse cliente
														   // e damos à atualizaTab a AVL de produtos correspondente
		a = travessiaQ11Cli(a,f->dir);
	}
	return a; 
}
/*travessia da avl de prods por cliente , produto a produto*/
AVL travessiaQ11Prod (AVL a,AVL prods,char* cliente) {
	if (!prods);
	else {
		a = travessiaQ11Prod(a,prods->esq,cliente);

		a = inserePAVL(a,pcfilToProdUni(prods->info,cliente));

		a = travessiaQ11Prod(a,prods->dir,cliente);
	}
	return a; 
}
/*Serve para passar o endereço do int aum*/
AVL inserePAVL(AVL a,void* str){
	int aum = 0;
	a = insereProdAVL(a,str,&aum);
	return a;
}

/*Funçao que inserere o produto numa avl verificando se o produto ja existe ou nao(inserindo-o) e se existir verifica se esse produto foi comprado pelo msm cliente*/
AVL insereProdAVL (AVL a, void* str, int *aum) {
	if (!a) {
		a = malloc(sizeof(struct avl));
		a->info = str;
		a->esq = a->dir = NULL;
		a->bal = Bal;
		*aum = 1;
	}	

	else if (!comparaProdUni(a->info,str))
		a->info = insereProdUni(a->info,str,existeCliente(a->info,str));

	else if (comparaProdUni(str,a->info) < 0) {
		a->esq = insereProdAVL(a->esq,str,aum);
		if (*aum == 1) {
			if (a->bal == Dir) { a->bal = Bal; *aum = 0; }
			if (a->bal == Bal) a->bal = Esq;
			else { a = corrigeL(a); *aum = 0; }
		}
	}
	else  {
		a->dir = insereProdAVL(a->dir,str,aum);
		if (*aum == 1) {
			if (a->bal == Esq) { a->bal = Bal; *aum = 0; }
			if (a->bal == Bal) a->bal = Dir;
			else { a = corrigeR(a); *aum = 0; }
		}
	}
	return a;
}
/*Insere parametros de f em pu*/
Prod_Uni insereProdUni(Prod_Uni pu,Prod_Uni f,int tipo){
	if(tipo ==0) pu->uni+=f->uni;
	else {
		pu->uni+=f->uni;
		pu->clientes[pu->clis]=strdup(f->clientes[0]);
		pu->clis++;
	}
return pu;
}
/*Travessia na avl dos produtos comprados (retornada pela funçao travessiaCliQ11) */
Array_Prod prodsQ11 (Array_Prod a, AVL prods,int N) {
	if (!prods);
	else {
		a = prodsQ11(a,prods->esq,N);
		a = comparaMaisVenda(a,prods->info,N);
		a = prodsQ11(a,prods->dir,N);
	}
	return a; 
}

/*Verifica se as unidades do produto sao maiores que alguma das unidades do array de N mais vendidos ate ao momento*/
int maisUni(int* a,int u,int N){
	for (int i = 0; i < N; ++i)
	{
		if(a[i]<u) return 1;
	}
	return 0;
}
/*retorna o indice do produto com menos unidades vendidas*/
int minProd(int* uni,int N){
	int min = uni[0];
   	int loc = 0;
    for (int c = 1; c < N; c++)
    {
        if (uni[c] < min)
        {
           min = uni[c];
           loc = c;

        }
    }
return loc;
}
/*Insere parametros de um Prod Uni num Array_Prod*/
Array_Prod insereArrayProd(Array_Prod s,Prod_Uni a,int i,int tipo){
		s->prod[i]= strdup(a->prod);
		s->uni[i]=a->uni;
		s->clis[i]=a->clis;
		
		if (tipo == 0) s->num++;
	
	return s;
}
/*Verifica se ainda falta preencehr o array do N mais vendidos , caso esteja cheio vê se o produto a inserir tem mais unidades vendidas se sim substitui*/
Array_Prod comparaMaisVenda(Array_Prod s,Prod_Uni a,int N){
	if(s->num<N) return insereArrayProd(s,a,s->num,0);
	if(maisUni(s->uni,a->uni,N)) return insereArrayProd(s,a,minProd(s->uni,N),1);

return s;
}

/*Query 12*/
/*Inicializa um Array_Fact*/
Array_Fact init_Arrf () {
	Array_Fact l = malloc(sizeof(struct arr_fact));
	l->prod = malloc(3*sizeof(char*));
	l->fact = malloc(3*sizeof(double));
	for (int i = 0; i < 3; ++i) {
		l->fact[i] = 0;
		l->prod[i] = "";
	}
	l->num = 0;
	return l;
}

/*Liberta a memória alocada por um Array_Fact*/
void free_Arrf (Array_Fact a) {
	for (int i = 0; i < 3; i++)
		free(a->prod[i]);
	free(a->prod);
	free(a->fact);
	free(a);
} 

/*Percorre uma AVL ordenada por códigos de produtos produzindo 
 um Array_Fact com os dados dos 3 produtos que deram mais lucro*/
Array_Fact prodsQ12 (Array_Fact a, AVL prods) {
	if (!prods);
	else {
		a = prodsQ12(a,prods->esq);

		a = comparaArrayFact(a,prods->info);
			
		a = prodsQ12(a,prods->dir);
	}
	return a;
}

/*Percorre uma AVL ordenada por códigos de clientes em buscar de um determinado cliente*/
Array_Fact lookupCliente (char* cod, Array_Fact a, AVL f) { /*filial n */
 	if (!f);
	else {
		a = lookupCliente(cod,a,f->esq);

		if (!comparaClis(getCliFil(f->info),criaCli(cod)))
			return prodsQ12(a,getAVLVFil(f->info)); 

		a = lookupCliente(cod,a,f->dir);
	}
	return a; 
}
