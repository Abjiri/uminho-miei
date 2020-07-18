import java.io.*;
import java.util.*;
import java.net.*;

/**
 * Responsavel por enviar pedidos ao servidor e responder ao peer anterior
 */
public class ServerReaderWriter implements Runnable {
    Pacote p;
    Tabela tab;
    Arguments args;

    public ServerReaderWriter(Arguments arg, Pacote pk, Tabela tb) {
        this.p = pk;
        this.tab = tb;
        this.args = arg;
    }       
        
    public void run() {
        try {
            System.out.println("Conexao ao sv " + this.p.getTarget() + " porta " + this.p.getPort() );
            Socket socket = new Socket(this.p.getTarget(),this.p.getPort());                                                  
            OutputStream out = socket.getOutputStream();
            InputStream in = socket.getInputStream();
            int id = this.p.getIDCliente();   
            System.out.println("Escrevendo para o sv " + new String(this.p.getNakedData()));   
            out.write(this.p.getNakedData(),0,this.p.getSize());                                                      
            out.flush();  
            ackPedido();
            
            if(this.p.isUltimo()){            
                this.tab.addResposta(id, -1);
                DatagramSocket ds = new DatagramSocket();  
                InetAddress peer = this.p.getPeer();
                ArrayList<Pacote> pacotes=lerInput(in);
                int i = 0;                         
                for (Pacote ps : pacotes){
                    byte[] encriptado = Encriptacao.encriptar(ps.getDados(), args.getPassword(), args.getKey1(), args.getKey2());
                    DatagramPacket dp = new DatagramPacket(encriptado, 1028, peer, 6666);
                    ds.send(dp); 
                    while(this.tab.getResposta(id) != i);
                    i++;
                }
                this.tab.removeResposta(this.p.getIDCliente());
                System.out.println("Todos os dados UDP enviados para o peer anterior");
            }
            socket.close();
        } 
        catch (Exception ex) {
            System.out.println("Erro ao enviar os pacotes ao servidor");
            System.out.println(ex.getStackTrace());
        }
    }

    public void ackPedido(){
        try {
            DatagramSocket ds = new DatagramSocket();
            InetAddress peer = this.p.getPeer();
            Pacote ps = new Pacote();
            ps.setAck(true);
            ps.setTipo(false);
            ps.setIDPacote(this.p.getIDPacote());
            ps.setIDCliente(this.p.getIDCliente());
            byte[] encripta = Encriptacao.encriptar(ps.getDados(),args.getPassword(), args.getKey1(), args.getKey2());
            DatagramPacket dp = new DatagramPacket(encripta, 1028, peer, 6666);
            ds.send(dp);
            ds.close();
        } catch (Exception ex) {
            System.out.println("Erro no ack de pedido");
            System.out.println(ex);
        }
        
    }
    
    public ArrayList<Pacote> lerInput(InputStream in) throws Exception {
        ArrayList<Pacote> pacotes = new ArrayList<>();
        int idPacote = 0;
        byte[] buffer;       
        Pacote last;
        int read;
        boolean le = true; 
        while(le){
            buffer = new byte[1000];
            Thread.sleep(10);
            read = in.read(buffer, 0, 1000);
            last = criarPacote(buffer, idPacote, read);
            System.out.println("Recebi do server: " + new String(buffer));
            if(read<0){
                last.setUltimo(true);
                le = false;
            }
            System.out.println("Enviado: ");
            last.print();
            idPacote++;
            pacotes.add(last);
        }
        return pacotes;   
    }

    private Pacote criarPacote(byte[] b, int idPacote, int size) throws Exception{
        Pacote p = new Pacote();
        p.setTipo(true); // 0 = pedido, 1 = resposta
        p.setAck(false);
        p.setUltimo(false);
        p.setIDPacote(idPacote);
        p.setTarget(this.p.getTarget());
        p.setPeer(getMyIp());
        p.setIDCliente(this.p.getIDCliente());
        p.setPort(this.p.getPort());
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
