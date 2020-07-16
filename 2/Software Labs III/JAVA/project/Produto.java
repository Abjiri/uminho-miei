import java.io.*;
import java.util.*;
import java.lang.*;

public class Produto implements Comparable<Produto>, Serializable {
   //Variaveis de Instancia 
   private int    flag; //para verificar se o produto foi comprado (e em que filiais foi comprado)
   private String codProd; 
    
   //Contrutor vazio
   public Produto() {
       this.flag    = 0;
       this.codProd = "";
   }
   
   //Construtor por parametros
   public Produto(int fla, String cod) {
       this.flag    = fla;
       this.codProd = cod;
   }
   
   //Construtor por copia
   public Produto(Produto p) {
       this.flag    = p.getFlag();
       this.codProd = p.getCodigo();
   }
   
   //Getters e Setters
   public int getFlag() { 
       return this.flag;
   } 
    
   public String getCodigo() { 
       return this.codProd;
   }
   
   //Metodos de instancia
   public Produto clone() {
       return new Produto(this);
   }
   
   @Override
   public boolean equals(Object o) {
       if (o == this) return true;
       if (o == null) return false;
       if (!(o instanceof Produto)) return false; 
       Produto c = (Produto) o; 
       return (Objects.equals(codProd,c.codProd));
   }
   
   @Override
   public int compareTo(Produto p) {
       return this.codProd.compareTo(p.getCodigo());
   }
   
   //Metodos de instancia
   public void mudarFlag(int fil) {
       	if (this.flag == 0) this.flag = fil;
	else if (fil == 1) {
		if (this.flag == 2) this.flag = 4;
		if (this.flag == 3) this.flag = 5;
		if (this.flag == 6) this.flag = 7;
	}
	else if (fil == 2) {
		if (this.flag == 1) this.flag = 4;
		if (this.flag == 3) this.flag = 6;
		if (this.flag == 5) this.flag = 7;
	}
	else if (fil == 3) {
		if (this.flag == 1) this.flag = 5;
		if (this.flag == 2) this.flag = 6;
		if (this.flag == 4) this.flag = 7;
	}
   }
   
   //Metodos de classe
   public static Produto linhaToProduto(String linha) {
        String codProd = linha.substring(0,6); //para nao ficar com os espaços que possam existir a seguir do codigo do Produto
        int flag = 0;
        return new Produto(flag,codProd);
   }
   
   public static boolean validaProduto(Produto pd) {
       String[] campos = (pd.getCodigo()).split("(?!^)"); //separa as letras do codP num array de strings
       
       for (int i = 0; i < 2; i++) 
           if (!Character.isUpperCase(campos[i].charAt(0))) return false; //.charAt(0): string para char 
       for (int i = 2; i < 6; i++) 
	   if (!Character.isDigit(campos[i].charAt(0))) return false;
       if (campos[2] == "0") return false;	
  
       return true;
   }

}
