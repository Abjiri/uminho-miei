import java.net.ServerSocket;
import java.net.Socket;
import java.util.List;

public class TCPWorker implements Runnable{
    Tabela tab;
    Arguments args;
    
    public TCPWorker (Tabela tb,Arguments arg) {
        this.tab = tb;
        this.args = arg;
    }
    
    public void run () {
        System.console().writer().println("Thread de leitura TCP inicializada...");
        
        try {
            ServerSocket ss = new ServerSocket(args.getPort());
            Socket s;
            List<String> peers = args.getPeers();
            int size = peers.size();
            String peer;
            int i = 0;
            int id = 0;

            while(true){  
                s = ss.accept();
                tab.addCliente(id,s);
                peer = peers.get(i);
                ClienteReader prim = new ClienteReader(this.args,s,peer,this.tab,id,args.getTarget(),args.getPort()); 
                i = (i + 1) % size; // round robbin
                id++; // atualizar id
                Thread t1 = new Thread(prim);                   
                t1.start(); 
                System.out.println("Novo Cliente " + s.getRemoteSocketAddress());
            }
        } catch (Exception ex) {
            System.out.println("Erro no leitor TCP");
            System.out.println(ex.getStackTrace());
        }
          
    }
}

