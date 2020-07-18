import java.net.Socket;
import java.util.concurrent.ConcurrentHashMap;

public class Tabela {
    private ConcurrentHashMap<Integer, Socket> clientes;  // id cl -> socket  
    private ConcurrentHashMap<Integer, Integer> clientePackets; // cl -> anongw
    private ConcurrentHashMap<Integer, Integer> serverPackets; // anongw -> cl

    public Tabela(){
        this.clientes = new ConcurrentHashMap<>();
        this.clientePackets = new ConcurrentHashMap<>();
        this.serverPackets = new ConcurrentHashMap<>();
    }

    public Socket getSocket(int cl){
        return this.clientes.get(cl);
    }

    public void addCliente(int id, Socket s){
        this.clientes.put(id, s);
    }

    public void removeCliente(int id){
        this.clientes.remove(id);
    }

    public void addPedido(int id, int valor){
        this.clientePackets.put(id, valor);
    }

    public int getPedido(int id){
        return this.clientePackets.get(id);
    }

    public void removePedido(int id){
        this.clientePackets.remove(id);
    }
 
    public void addResposta(int id, int valor){
        this.serverPackets.put(id, valor);
    }

    public int getResposta(int id){
        return this.serverPackets.get(id);
    }

    public void removeResposta(int id){
        this.serverPackets.remove(id);
    }

}