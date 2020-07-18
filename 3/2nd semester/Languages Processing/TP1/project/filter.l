%option noyywrap yylineno
%x DIV META SAVEMETA HYPHENS NAME EXTENSION NEWLINES TOFILE

%{
#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include "map.h"

#define maxDir 5 //estabelece-se uma profundidade maxima arbitraria de 5 para a tree

char *newMeta; //nome de cada metadado novo durante a recolha
char *name; //nome de cada elemento da tree a medida que a percorre
char *writeTo; //nome de cada ficheiro para o qual vai escrever
char *dir[maxDir]; //nome da pasta mais recente em cada profundidade, para saber a rota dos ficheiros a criar
struct map* meta; //mapa de metadados com par (nome,valor)
struct map* files; //mapa de ficheiros com par (nome,apontador)
int hyphens = 0; //numero de hifens de cada elemento da tree para saber a sua profundidade

char* buildRoute(); //retorna a rota completa do ficheiro/pasta em questao
char* getMetaKey(char* yytext); //retira o nome do metadado de uma string filtrada do formato {%...%}
char* getMetaFilename(char* yytext); //retorna o nome do ficheiro/pasta com valor do metadado e extensao, se tiver
char* append(char* str1, char* str2, char separator); //da append de uma string a outra
%}

%%

<*>===[ ]*						{ if (writeTo) { free(writeTo); writeTo = NULL; }
								} BEGIN DIV; //apaga o nome do ultimo ficheiro para o qual escreveu

<DIV>meta				   		BEGIN META; //condicao para recolher metadados
<DIV>tree						BEGIN NAME; //condicao para construir a tree
<DIV>"{%".+"%}".*				{ writeTo = getMetaFilename(yytext); } BEGIN NEWLINES;
<DIV>.+							{ writeTo = strdup(yytext); } BEGIN NEWLINES;

<META>^.+:[ ]*					{ //numero de espaços que haja e irrelevante
									newMeta = strdup(strtok(yytext,":")); //guarda o nome do novo metadado
								} BEGIN SAVEMETA;

<SAVEMETA>.+ 					{ //guarda a key/value do metadado no mapa
									mapDynAdd(newMeta,strdup(yytext),meta); //guara o nome e respetivo valor do metadado no mapa
									free(newMeta); //liberta memoria alocada para o nome
								} BEGIN META;

<HYPHENS>-+[ ]*	 				{ //numero de espaços que haja e irrelevante
									hyphens = 0; 
									while (yytext[hyphens] == '-') hyphens++; //para saber a profundidade a que se encontra
									
									if (name) { free(name); name = NULL; } //liberta a memoria alocada ao nome do ficheiro/pasta anterior
									
									if (hyphens <= maxDir && dir[hyphens-1]) BEGIN NAME; //so cria o ficheiro se a sua localizacao for valida
								} //p.e. se dir atual for name/doc e aparecer ---exemplo.txt, localizacao invalida

<NAME>"{%".+"%}"[^\n\/]*		{ //apanha nomes com metadados
									name = getMetaFilename(yytext); //guarda o valor do metadado em questao

									if (strchr(name,'/')) BEGIN HYPHENS; //metadado respetivo tem '/', nome invalido
									else BEGIN EXTENSION;
								}

<NAME>[^\n\/]+					{ //apanha outros nomes						
									name = strdup(yytext); //guarda o nome do ficheiro/pasta
								} BEGIN EXTENSION;

<EXTENSION>\/.*					{
									if (strlen(yytext) == 1) { //nome tem '/', invalido em ficheiros/pastas em sistema Linux

										for (int i = hyphens; i < maxDir; i++) { ////substitui o nome da pasta a uma certa profundidade
											if (dir[i]) {
												free(dir[i]); //apaga tambem os nomes das pastas dentro da anterior
												dir[i] = NULL;
											}
										}
										dir[hyphens] = strdup(name); //pela nova encontrada na tree

										char* route = buildRoute(); //cria a rota da nova pasta
										mkdir(route,0700); //cria a pasta

										free(route); //liberta a memoria alocada para a rota
									}
								} BEGIN HYPHENS;
<EXTENSION>\n					{
									char* route = buildRoute(); //cria a rota do novo ficheiro

									FILE *fd = fopen(route,"w"); //cria o ficheiro
									mapDynAdd(name,fd,files); //adiciona o nome e o apontador ao mapa

									free(route); //liberta a memoria alocada para a rota
								} BEGIN HYPHENS;

<NEWLINES>\n+ 				BEGIN TOFILE; //tira os paragrafos vazios no inicio dos ficheiros

<TOFILE>"{%"([^\%\}]|[^\%]\}|\%[^\}])+"%}"	{ fprintf(mapGet(writeTo,files),"%s",(char*) mapGet(getMetaKey(yytext),meta)); 
											} //imprime o valor do metadado em questao

<TOFILE>.|\n 					{ fprintf(mapGet(writeTo,files),"%s",yytext); } //transcreve texto para o ficheiro rspetivo

<*>.|\n                    		; //ignora tudo o resto que nao e apanhado nas regex acima

%%

char* buildRoute() {
	char* route = NULL;

	for (int i = 0; i < hyphens; i++)
		route = append(route,dir[i],'/'); //adiciona as pastas a route
	
	return append(route,name,'/'); //adiciona o nome do ficheiro/pasta nova
}

char* getMetaKey(char* yytext) { //retorna a palavra entre {% e %}
	char* key = strtok(yytext,"%");
	return strtok(NULL,"%");
}

char* getMetaFilename(char* yytext) {
	char* key = getMetaKey(strdup(yytext)); //vai buscar a palavra entre {% e %}
	char* name = strdup(mapGet(key,meta)); //vai buscar o metadado correspondente
	
	return append(name,yytext+strlen(key)+4,'!'); //adiciona a extensao, se tiver uma
}

char* append(char* str1, char* str2, char separator) { //aloca memoria para ambas as strings e da append de str2 a str1
	char * new_str;

	if (!str1) new_str = strdup(str2);
	else {
		int len = strlen(str1);

		new_str = malloc(len+strlen(str2)+2);
		new_str[0] = '\0'; //assegura que a memoria e uma string vazia
    	strcat(new_str,str1);

    	if(separator != '!') { //damos '!' quando nao queremos nenhum separador
	    	new_str[len] = separator;
    		new_str[len+1] = '\0';
    	}

    	strcat(new_str,str2);
        free(str1);
    }

    return new_str;
}

int main(int argc, char* argv[]) {
	yyin = fopen(argv[2],"r");	//abre o template para ler
	
	//inicializa variaveis
	meta = mapNew(); //cria mapa de metadados
	files = mapNew(); //cria mapa de ficheiros

	mapDynAdd("name",strdup(argv[1]),meta); //adiciona o name aos metadados
	newMeta = name = writeTo = NULL;

	for (int i = 0; i < maxDir; i++)
		dir[i] = NULL;

	yylex(); //corre o programa flex
	
	//fecha apontadores e liberta memoria alocada
	mapCloseMeta(meta);
	mapCloseFiles(files);
	fclose(yyin);

	//damos free a newMeta durante a execucao do programa
	free(name); //vamos dando free a esta var ao longo do programa exceto da ultima vez que e alocada, porque depois nao entra no <HYPHENS>
	free(writeTo);

	for (int i = 0; i <= maxDir; i++)
		if (dir[i]) free(dir[i]);

	return 0;
}