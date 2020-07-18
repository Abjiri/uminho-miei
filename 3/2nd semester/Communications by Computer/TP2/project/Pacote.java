import java.net.*;
import java.nio.*;
import java.util.*;

public class Pacote {

    private byte[] dados;

    public Pacote(){
        this.dados = new byte[1028];
    }

    public Pacote(byte[] b){
        this.dados = b;
    }

    public byte[] getDados(){
        return this.dados;
    }

    public void setTipo(boolean b){
        if(b) dados[0] = 1; else dados[0] = 0;
    }

    public boolean isResposta(){
        return dados[0] == 1;
    }

    public void setAck(boolean b){
        if(b) dados[1] = 1; else dados[1] = 0;
    }

    public boolean isAck(){
        return dados[1] == 1;
    }

    public void setUltimo(boolean b){
        if(b) dados[2] = 1; else dados[2] = 0;
    }

    public boolean isUltimo(){
        return dados[2] == 1;
    }
    
    public void setIDPacote(int id){
        byte[] x = ByteBuffer.allocate(4).putInt(id).array();
        int i = 3;
        for(byte xx : x){
            this.dados[i++] = xx;
        }
    }

    public int getIDPacote(){
        return ByteBuffer.wrap(this.dados, 3, 4).getInt();
    }

    public void setTarget(InetAddress ip){
        int value = ByteBuffer.wrap(ip.getAddress()).getInt();
        byte[] x = ByteBuffer.allocate(4).putInt(value).array();
        int i = 7;
        for(byte xx : x){
            this.dados[i++] = xx;
        }
    }

    public InetAddress getTarget() throws Exception{
        int pp = ByteBuffer.wrap(this.dados, 7, 4).getInt();
        return InetAddress.getByName(String.valueOf(pp));
    }

    public void setPeer(InetAddress ip){
        int value = ByteBuffer.wrap(ip.getAddress()).getInt();
        byte[] x = ByteBuffer.allocate(4).putInt(value).array();
        int i = 11;
        for(byte xx : x){
            this.dados[i++] = xx;
        }
    }

    public InetAddress getPeer() throws Exception {
        int pp = ByteBuffer.wrap(this.dados, 11, 4).getInt();
        return InetAddress.getByName(String.valueOf(pp)); 
    }

    public void setIDCliente(int id){
        byte[] x = ByteBuffer.allocate(4).putInt(id).array();
        int i = 15;
        for(byte xx : x){
            this.dados[i++] = xx;
        }
    }

    public int getIDCliente(){
        return ByteBuffer.wrap(this.dados,15,4).getInt();
    }

    public void setPort(int p){
        byte[] x = ByteBuffer.allocate(4).putInt(p).array();
        int i = 19;
        for(byte xx : x){
            this.dados[i++] = xx;
        }
    }

    public int getPort(){
        return ByteBuffer.wrap(this.dados,19,4).getInt();
    }

    public void setSize(int y){
        int len = y;
        if(y==-1){
            len = 0;
        }
        byte[] x = ByteBuffer.allocate(4).putInt(len).array();
        int i = 23;
        for(byte xx : x){
            this.dados[i++] = xx;
        }
    }

    public int getSize(){
        return ByteBuffer.wrap(this.dados,23,4).getInt();
    }

    public void setData(byte[] b, int size){
        if(size == -1){
            return;
        }
        int i = 27;
        int j;
        for(j = 0; j < size; j++){
            this.dados[i++] = b[j];
        }
    }

    public void alterarBuffer(byte[] b){
        this.dados = b;
    }

    public byte[] getNakedData(){
        return Arrays.copyOfRange(this.dados, 27, 27 + this.getSize());
    }

    public void print() throws Exception{
        System.out.println("Tipo " + this.dados[0]);
        System.out.println("Ack " + this.dados[1]);
        System.out.println("Ultimo "+ this.dados[2]);
        System.out.println("ID pacote" + this.getIDPacote());
        System.out.println("Target " + this.getTarget());
        System.out.println("Peer " + this.getPeer());
        System.out.println("IDcliente " + this.getIDCliente());
        System.out.println("Port " + this.getPort());
        System.out.println("Size " + this.getSize());
        System.out.println("data " + new String(this.getNakedData()));
    }
}