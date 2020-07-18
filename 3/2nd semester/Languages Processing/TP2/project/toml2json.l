%option noyywrap yylineno
%x BLOCO NOMEBLOCO VALORBLOCO VALOR ARRAY ASPAS
%{
#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include "y.tab.h"

#define MAXBLOCO 1024

int tokens[3] = {0}; //FIMBLOCO, '[', chave
char *blocos[MAXBLOCO];

int primeiroBloco = 0;
int blocoAtual = 0;
int blocoDpsTokens = 0;

int arrayAtual = 0;
int decArrayAtual = 0;

int blocoAspas = 0;
int chaveComposta = 0;
char* chaveBlocoAtual = NULL;

int tokensAcumulados();
void atualizaBlocos();

%}

digito    [0-9]
acentos   \xc3[\x80-\xbf]         
letra     [a-zA-Z]|{acentos}       
palavra   {letra}+  
espacos   [ ]*
chave     [a-z][^ \,\.\n\t\r\[\]\"]*
nullbool  (true)|(false)|(null)
num       (\+|-)?[0-9]+(\.[0-9]+)?

%%
  if (decArrayAtual == 1) {arrayAtual--; decArrayAtual = 0;}
  if (blocoAtual > blocoDpsTokens) blocoAtual--;
  if (blocoAtual < blocoDpsTokens) blocoAtual++;

  int token = tokensAcumulados();
  switch(token){
    case 0: return FIMBLOCO;
    case 1: return '[';
    case 2: {
              if (chaveBlocoAtual) yylval.s = strdup(chaveBlocoAtual);
              else yylval.s = strdup(blocos[blocoAtual-1]); 
              return chave;
            }
    case 3: {
              yylval.s = strdup(chaveBlocoAtual);
              free(chaveBlocoAtual); chaveBlocoAtual = NULL;
              return chave;
            }
  }

<*>#.*                                          {}

<NOMEBLOCO>\[                                   {tokens[1] = 1;}
<NOMEBLOCO>[^\]\[\n]+                           {
                                                  atualizaBlocos(yytext);
                                                  int token = tokensAcumulados();
                                                  if (token == 0) return FIMBLOCO;
                                                  if (token == 1) return '[';
                                                }
<NOMEBLOCO>\]                                   {return ']';}
<NOMEBLOCO>{espacos}\n{espacos}/\[?             {BEGIN BLOCO; return FIMTAG;}                                                                        

<BLOCO>\.                                       {return '.';}
<BLOCO>\"                                       {chaveComposta = 1; BEGIN ASPAS;}
<BLOCO>{chave}                                  {BEGIN VALORBLOCO; yylval.s = strdup(yytext); return chave;}
<BLOCO>\[                                       {tokens[1] = 1; BEGIN NOMEBLOCO;}

<VALORBLOCO>{espacos}=                          {return '=';}
<VALORBLOCO>{espacos}\"                         {blocoAspas = 1; BEGIN ASPAS; return '"';}
<VALORBLOCO>{espacos}\[                         {BEGIN ARRAY; arrayAtual++; return '[';}
<VALORBLOCO>{espacos}                           {BEGIN VALOR;}

<VALOR>{nullbool}                                 {
                                                  if(chaveBlocoAtual) BEGIN 0;
                                                  else BEGIN BLOCO;
                                                  yylval.s = strdup(yytext); 
                                                  return valor;
                                                }
<VALOR>{num}                                      {
                                                  if(chaveBlocoAtual) BEGIN 0;
                                                  else BEGIN BLOCO;
                                                  if(yytext[0] == '+') yylval.s = strdup(yytext+1);
                                                  else yylval.s = strdup(yytext);
                                                  return valor;
                                                }
<VALOR>[^ \t\n\r#]+                             {
                                                  if(chaveBlocoAtual) BEGIN 0;
                                                  else BEGIN BLOCO;
                                                  char* text = malloc(strlen(yytext)+2); 
                                                  sprintf(text,"\"%s\"",yytext); 
                                                  yylval.s = strdup(text);
                                                  free(text);
                                                  return valor;
                                                }

<ARRAY>,                                        {return ',';}
<ARRAY>\"                                       {blocoAspas = 2; BEGIN ASPAS; return '"';}
<ARRAY>{nullbool}                               {yylval.s = strdup(yytext); return valor;}
<ARRAY>{num}                                    {
                                                  if(yytext[0] == '+') yylval.s = strdup(yytext+1);
                                                  else yylval.s = strdup(yytext);
                                                  return valor;
                                                }
<ARRAY>[^,\"\[\] \n\t\r]+                       {
                                                  char* text = malloc(strlen(yytext)+2); 
                                                  sprintf(text,"\"%s\"",yytext); 
                                                  yylval.s = strdup(text);
                                                  free(text);
                                                  return valor;
                                                }
<ARRAY>\[                                       {arrayAtual++; return '[';}
<ARRAY>\]                                       {
                                                  decArrayAtual = 1; 
                                                  if(arrayAtual-1 == 0) BEGIN BLOCO;
                                                  if(chaveBlocoAtual) BEGIN 0;
                                                  return ']';
                                                }

<ASPAS>\"                                       {
                                                  if(chaveComposta==1) {chaveComposta=0; BEGIN VALORBLOCO;}
                                                  else {
                                                    if(blocoAspas == 1) BEGIN BLOCO;
                                                    if(blocoAspas == 2) BEGIN ARRAY;
                                                    if(chaveBlocoAtual) BEGIN 0;
                                                    blocoAspas = 0;
                                                    return '"';
                                                  }
                                                }
<ASPAS>[^"]+                                    {
                                                  yylval.s = strdup(yytext);
                                                  if(chaveComposta==1) return chave;
                                                  else return string;
                                                }

<*><<EOF>>                                      {
                                                  if (blocoDpsTokens > 0) {
                                                    tokens[0] = blocoDpsTokens-1;
                                                    blocoDpsTokens = 0;
                                                    return FIMBLOCO;
                                                  }
                                                  else if (primeiroBloco == 0) {
                                                    primeiroBloco = 1;
                                                    return INITBLOCOS;
                                                  }
                                                  else yyterminate();
                                                }

<*>{espacos}\n{espacos}/\[                      {
                                                  BEGIN NOMEBLOCO;
                                                  if (primeiroBloco == 0) {
                                                    primeiroBloco = 1;
                                                    return INITBLOCOS;
                                                  }
                                                  if (chaveBlocoAtual) {
                                                    free(chaveBlocoAtual); chaveBlocoAtual = NULL;
                                                    tokens[1] = 1;
                                                    return FIMCHAVEBLOCO;
                                                  }
                                                }

<*>{chave}/\.                                   {
                                                  BEGIN BLOCO;
                                                  if (chaveBlocoAtual) {
                                                    if (strcmp(chaveBlocoAtual,yytext)!=0) {
                                                      free(chaveBlocoAtual); chaveBlocoAtual = NULL;
                                                      chaveBlocoAtual = strdup(yytext);
                                                      tokens[2] = 1;
                                                      tokens[0] = -1;
                                                      return FIMCHAVEBLOCO;
                                                    }
                                                  }
                                                  else chaveBlocoAtual = strdup(yytext);
                                                  yylval.s = strdup(yytext); 
                                                  return chave;
                                                }
<*>{chave}                                      {
                                                  BEGIN VALORBLOCO; 
                                                  if(chaveBlocoAtual) {
                                                    free(chaveBlocoAtual); chaveBlocoAtual = NULL;
                                                    chaveBlocoAtual = strdup(yytext);
                                                    tokens[2] = -1;
                                                    return FIMCHAVEBLOCO;
                                                  }
                                                  yylval.s = strdup(yytext); 
                                                  return chave;
                                                }
<*>{espacos}\n                                  {}
<*>.                                            {}

%%

int tokensAcumulados() {
  if (tokens[0] > 0) {
    if (tokens[0] == 1) {tokens[0] = -1;}
    else {tokens[0]--;}
    return 0;
  }
  if (tokens[0] == -1 && tokens[1] > 0) {
    tokens[1] = 0;
    return 1;
  }
  if (tokens[0] == -1 && tokens[2] > 0) {
    tokens[2] = 0;
    return 2;
  }
  if (tokens[2] == -1) {
    tokens[2] = 0;
    return 3;
  }
  tokens[0] = 0;
  return -1;
}

void atualizaBlocos(char* yytext) {
  int subbloco = 0;
  int blocoInit = blocoAtual;

  if (blocoAtual > 0) {
    char blocoAcima[1024];
    for (int i = blocoAtual-1; i >= 0; i--) {
      sprintf(blocoAcima,"%s.",blocos[i]);
      char* pos = strstr(yytext, blocoAcima);

      if(pos != NULL) { //subbloco
        if (i == blocoAtual-1) { //subbloco num novo nivel: servers -> servers.alpha
          blocos[blocoAtual] = strdup(pos+strlen(blocoAcima));
          blocoDpsTokens = blocoAtual+1;
        }
        else { //subbloco no nivel atual: servers.alpha -> servers.beta
          for (int j = i+1; j < blocoAtual; j++){
            free(blocos[j]);
            blocos[j] = NULL;
          }
          blocos[i+1] = strdup(pos+strlen(blocoAcima));
          blocoDpsTokens = i+2;
        }
        subbloco = 1;
        break;
      }
    }
  }

  if (subbloco == 0) {
    for (int i = 0; i < blocoAtual; i++){
      free(blocos[i]);
      blocos[i] = NULL;
    }
    blocos[0] = strdup(yytext);
    blocoDpsTokens = 1;
  }

  if (blocoInit >= blocoDpsTokens) tokens[0] = blocoInit-blocoDpsTokens+1;
  else tokens[0] = -1;
  tokens[2] = 1;
}
