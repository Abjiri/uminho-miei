import java.io.*;
import java.util.*;
import java.lang.*;

public class Cliente implements Comparable<Cliente>, Serializable {
   //Variaveis de Instancia 
   private int flag;
   private String codCli; 
    
   //Contrutor vazio
   public Cliente () {
       this.flag   = 0;
       this.codCli = "";
   }
   
   //Construtor por parametros
   public Cliente (int fla, String cod) {
       this.flag   = fla;
       this.codCli = cod;
   }
   
   //Construtor por copia
   public Cliente (Cliente c) {
       this.flag    = c.getFlag();
       this.codCli  = c.getCodigo();
   }
   
   //Getters e Setters
   public int getFlag() { 
       return this.flag;
   } 
    
   public String getCodigo() { 
       return this.codCli;
   }
   
   //Metodos de instancia
   public Cliente clone() {
       return new Cliente(this);
   }
   
   @Override
   public boolean equals(Object o) {
       if (o == this) return true;
       if (o == null) return false;
       if (!(o instanceof Cliente)) return false; 
       Cliente c = (Cliente) o; 
       return (Objects.equals(codCli,c.codCli));
   }
   
   @Override
   public int compareTo (Cliente c) {
       return this.codCli.compareTo(c.getCodigo());
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
   public static Cliente linhaToCliente(String linha) {
        String codCli = linha.substring(0,5);
        int flag = 0;
        return new Cliente(flag,codCli);
   }
   
   public static boolean validaCliente(Cliente cl) {
       String[] campos = (cl.getCodigo()).split("(?!^)"); 
       for (int i = 0; i < 1; i++) 
           if (!Character.isUpperCase(campos[i].charAt(0))) return false;
       for (int i = 1; i < 5; i++) 
           if (!Character.isDigit(campos[i].charAt(0))) return false;
       if (campos[1] == "0") return false;  
  
       return true;
   }

}
