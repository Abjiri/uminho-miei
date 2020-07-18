import java.io.*;
import java.util.*;
import java.net.*;

public class ClienteReader implements Runnable {
    Socket s;
    Tabela tab;
    String peer; 
    String target; 
    int id;
    int port;
    Arguments args;
    
    public ClienteReader (Arguments arg, Socket skt, String peer, Tabela tb, int idC, String tg, int p){
        this.s = skt;
        this.target = tg;
        this.peer = peer;
        this.id = idC;
        this.tab = tb;
        this.port = p;
        this.args = arg;
    }
    
    public void run() {
        try {   
            this.tab.addPedido(id, -1);
            ArrayList<Pacote> pacotes = lerInput();
            DatagramSocket udp = new DatagramSocket();
            InetAddress peerHop = InetAddress.getByName(this.peer);
            DatagramPacket p;     
            int i = 0;
            for(Pacote pk: pacotes){
                byte[] encriptado = Encriptacao.encriptar(pk.getDados(), args.getPassword(), args.getKey1(), args.getKey2());
                p = new DatagramPacket(encriptado, 1028, peerHop,6666);
                udp.send(p);   
                while(this.tab.getPedido(this.id) != i); // garantir ordem
                i++;
            }
            this.tab.removePedido(this.id);
            udp.close();  
        } 
        catch (Exception ex) {
            System.out.println("Erro no worker do primario");
            System.out.println(ex.getMessage());
        }   
    }      

    public ArrayList<Pacote> lerInput() throws Exception {
        InputStream in = this.s.getInputStream();
        ArrayList<Pacote> pacotes = new ArrayList<>();
        int idPacote = 0;
        byte[] buffer;
        Pacote last;
        int read;  
        boolean le = true;      
        while(le){
            buffer = new byte[1000];
            read = in.read(buffer, 0, 1000);
            last = criarPacote(buffer, idPacote, read);
            if(read<1000){
                last.setUltimo(true);
                le = false;
            } 
            idPacote++;
            System.out.println("Enviado: ");
            last.print();
            pacotes.add(last);
        }
        return pacotes;   
    }

    private Pacote criarPacote(byte[] b, int idPacote, int size) throws Exception{
        Pacote p = new Pacote();
        p.setTipo(false); // 0 = pedido, 1 = resposta
        p.setAck(false);
        p.setUltimo(false);
        p.setIDPacote(idPacote);
        p.setTarget(InetAddress.getByName(this.target));
        p.setPeer(this.getMyIp());
        p.setIDCliente(this.id);
        p.setPort(this.port);
        p.setSize(size);
        p.setData(b, size);
        return p;
    }

    private InetAddress getMyIp() throws SocketException {
        return Collections.list(NetworkInterface.getNetworkInterfaces()).stream()
            .flatMap(i -> Collections.list(i.getInetAddresses()).stream())
            .filter(ip -> ip instanceof Inet4Address && ip.isSiteLocalAddress())
            .findFirst().orElseThrow(RuntimeException::new);
    }
      
}
