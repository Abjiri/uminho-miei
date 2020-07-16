#include "main.h"
#include "Queries.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>


SGV init_SGV () {
	SGV sgv = malloc(sizeof(struct sgv));

	sgv->catp = inicializa_CatProds();
	sgv->catc = inicializa_CatClis();
	sgv->catvfact = init_CatVFacts();
	sgv->catvfil = init_CatVFils();

	return sgv;
}

void free_SGV (SGV sgv) {
	free_Catp(sgv->catp);
	free_Catc(sgv->catc);
	free_CatVFacts(sgv->catvfact);
	free_CatVFils(sgv->catvfil);
	free(sgv);
}

Cat_Prods lerProds (Cat_Prods catp) {
	FILE *fp = fopen(FILEP, "r");
	if (!fp) { printf("I/O error\n"); exit(1); }

	char* codProd = malloc(STRP);

	while (fgets(codProd,STRP,fp)) {
		strtok(codProd,"\n\r");
		catp = incTotalProds(catp);

		if (validaProduto(codProd))
			catp = insereProd(catp,criaProd(codProd));
	}

	free(codProd);
    fclose(fp);
    return catp;
}

Cat_Clis lerClis (Cat_Clis catc) {
	FILE *fp = fopen(FILEC, "r");
	if (!fp) { printf("I/O error\n"); exit(1); }

	char* codCli = malloc(STRC);

	while (fgets(codCli,STRC,fp)) {
		strtok(codCli,"\n\r");
		catc = incTotalClis(catc);

		if (validaCliente(codCli))
			catc = insereCli(catc,criaCli(codCli));
	}

	free(codCli);
    fclose(fp);
    return catc;
}

SGV lerVendas (SGV sgv) {
	FILE *fp = fopen(FILEV, "r");
	if (!fp) { printf("I/O error\n"); exit(1); }

	char* codVend = malloc(STRV);

	while (fgets(codVend,STRV,fp)) {
		strtok(codVend,"\n\r");
		sgv->catvfact = incTotalVendas(sgv->catvfact);

		Venda v = mkVenda(codVend); /*estrutura temporária que contém os parâmetros todos da Venda*/

		if (validaVenda(v,sgv->catp,sgv->catc)) {
			sgv->catvfact = insereVFact(sgv->catvfact,criaVFact(v),v.mes-1);
			sgv->catvfil = insereVFil(sgv->catvfil,criaVFil(v.cliente),criaPCFil(v),v.filial-1);
			sgv->catp = mudaFlagProd(sgv->catp,criaProd(v.produto),v.filial);
			sgv->catc = mudaFlagCli(sgv->catc,criaCli(v.cliente),v.filial);
		}
	}
	free(codVend);
    fclose(fp);
    return sgv;
}

SGV lerFicheiros () {
	SGV sgv = init_SGV();
	sgv->catp = lerProds(sgv->catp);
	sgv->catc = lerClis(sgv->catc);
	sgv = lerVendas(sgv);
	return sgv;
}

int main () {
	clock_t start, end;
	double cpu_time_used;
	start = clock();

	SGV sgv = lerFicheiros();	/*leitura e validação dos ficheiros*/
	
	end = clock();
	cpu_time_used = ((double) (end-start))/CLOCKS_PER_SEC;
	printf("CPU Time:%f\n", cpu_time_used);
	
	loopQueries(sgv);
	return 0;
}