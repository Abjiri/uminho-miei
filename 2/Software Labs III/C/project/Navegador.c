#include <stdio.h>
#include <stdlib.h>
#define _GNU_SOURCE
#include <string.h>
#include "Navegador.h"

struct lst_str {
	char** strings;
	int pos;	/*posição atual*/
	int num;	/*total de strings*/
};

Lista_Strings init_Lista () {
	Lista_Strings l = malloc(sizeof(struct lst_str));
	l -> strings = malloc(sizeof(char*));
	l -> strings[0] = NULL;
	l -> pos = 0;
	l -> num = 0;
	return l;
}

Lista_Strings* init_arrLista (int n) {
	Lista_Strings* l = malloc(2*sizeof(struct lst_str));
	for (int i = 0; i < n; i++)
		l[i] = init_Lista();
	return l;
}

void freeLista (Lista_Strings l) {
	for (int i = 0; i < l->num+1; i++)
		free(l->strings[i]);
	free(l->strings);
	free(l);
}

Lista_Strings insereLista (Lista_Strings l, char* cod) {
	char** newStrings = (char**) realloc(l->strings, (l->num+2)*sizeof(char*));
	if (!newStrings) return l;

	char* novoCod = strdup(cod);
	if (!novoCod) return l;

	newStrings[l->num++] = novoCod;
	newStrings[l->num] = NULL;

	l->strings = newStrings;
	return l;
} 

int getNumLista (Lista_Strings l) {
	return l->num;
}

char** getStringsLista (Lista_Strings l) {
	return l->strings;
}

void cicloPrint (Lista_Strings l) {
	for (int i = l->pos; l->strings[i] && i < l->pos+20; i++) {
		printf("%s\n", l->strings[i]);
	}
}

Lista_Strings pagInicial (Lista_Strings l) {
	l->pos = 0;
	cicloPrint(l);
	return l;
}

Lista_Strings ultimaPag (Lista_Strings l) {
	int i;
	for (i = 0; l->num - i > 20; i+=20);
	l->pos = i;
	cicloPrint(l);
	return l;
}

Lista_Strings pagSeguinte (Lista_Strings l) {
	if (l->pos + 20 <= l->num) l->pos+=20;
	cicloPrint(l);
	return l;
}

Lista_Strings pagAnterior (Lista_Strings l) {
	if (l->pos - 20 < 0) l->pos = 0;
	else l->pos -= 20;
	cicloPrint(l);
	return l;
}

void menuNavegador () {
	printf("\n(s)Página seguinte   (w)Página anterior   (a)Primeira página   (d)Última Página   (q)Sair do navegador\n");
	printf("Escolha uma opção: ");
}

Lista_Strings escolheOpcao (Lista_Strings l, char* buf, char* frase) {
	if (buf[0] == 's' && buf[1] == '\n') { printf("\n%s\n",frase); l = pagSeguinte(l); }
	if (buf[0] == 'w' && buf[1] == '\n') { printf("\n%s\n",frase); l = pagAnterior(l); }
	if (buf[0] == 'a' && buf[1] == '\n') { printf("\n%s\n",frase); l = pagInicial(l); }
	if (buf[0] == 'd' && buf[1] == '\n') { printf("\n%s\n",frase); l = ultimaPag(l); }
	return l;
}

void navegador (Lista_Strings l, char* frase) {
	char* buf = malloc(10);
	printf("\n%s\n",frase);
	pagInicial(l);

	while (buf[0] != 'q' || buf[1] != '\n') {
		l = escolheOpcao(l,buf,frase);
		menuNavegador();
		buf = fgets(buf,10,stdin);
	}
	free(buf);
}