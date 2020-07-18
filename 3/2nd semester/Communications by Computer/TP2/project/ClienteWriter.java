import java.io.*;
import java.net.*;
/**
 * Responsavel por comunicar ao cliente e enviar ACK ao peer que lhe enviou o pacote
 */
public class ClienteWriter implements Runnable {
    Pacote p;
    Tabela tab;
    Arguments args;

    public ClienteWriter(Arguments arg, Pacote pk, Tabela tb) {
        this.p = pk;
        this.tab = tb;
        this.args = arg;
    }       
                    
    public void run() {        
        try {
            int idCliente = this.p.getIDCliente();
            Socket s = this.tab.getSocket(idCliente);
            OutputStream out = s.getOutputStream();
            out.write(this.p.getNakedData());
            out.flush();
            ackResposta();
            if(p.isUltimo()){
                this.tab.removeCliente(idCliente);
            }
        }
        catch (Exception ex) {
            System.out.println("Ocorreu erro no envio ao cliente");
        }
    }
    
    public void ackResposta(){
        try {
            DatagramSocket ds = new DatagramSocket();
            InetAddress peer = this.p.getPeer();
            Pacote ps = new Pacote();
            ps.setTipo(true);
            ps.setAck(true);
            ps.setIDPacote(this.p.getIDPacote());
            ps.setIDCliente(this.p.getIDCliente());
            byte[] encripta = Encriptacao.encriptar(ps.getDados(),args.getPassword(), args.getKey1(), args.getKey2());
            DatagramPacket dp = new DatagramPacket(encripta, 1028, peer, 6666);
            ds.send(dp);
        } 
        catch (Exception ex) {
            System.out.println("Erro no envio do ack de confirmaçao de resposta");
            System.out.println(ex.getMessage());
        }  
    }  
}
