import java.net.*;

public class UDPWorker implements Runnable {
    Tabela tab;
    Arguments args;
    
    public UDPWorker (Tabela tb, Arguments arg) {
        this.args = arg;
        this.tab = tb;
    }
    
    public void run() {
        try {
            DatagramSocket ds = new DatagramSocket(6666);
            System.out.println("Thread de leitura de UDP inicializada...");
            while(true){                  
                byte[] buffer = new byte[1028];
                DatagramPacket pkt = new DatagramPacket(buffer, 1028);  
                ds.receive(pkt);
                Pacote p = new Pacote(buffer);
                byte[] desencripta = Encriptacao.desencriptar(buffer, args.getPassword(), args.getKey1(), args.getKey2());
                p.alterarBuffer(desencripta);
                System.out.println("Recebi um pacote");
                p.print();
                if(p.isAck()){ // caso pacote seja um ack
                    System.out.print("Recebi 1 ACK ");  
                    if (p.isResposta()){ // caso seja um pacote de resposta
                        System.out.println(" de resposta");
                        this.tab.addResposta(p.getIDCliente(),p.getIDPacote());    
                    } 
                    else { // caso pacote seja um pedido
                        System.out.println(" de pedido");
                        this.tab.addPedido(p.getIDCliente(),p.getIDPacote());
                    }
                }    
        
                else{ // se nao for um ack, e um pacote de pedido/resposta   
                    System.out.print("Recebi nao um ack: ");   
                    if(p.isResposta()){    // caso seja para enviar de volta para o cliente (resposta)
                        System.out.println("resposta");   
                        ClienteWriter sec1 = new ClienteWriter(args,p,tab);
                        Thread t1 = new Thread(sec1);                     
                        t1.start();   
                    }               
                    else { // se nao, e para enviar para o target server
                        System.out.println("pedido");   
                        ServerReaderWriter sec2 = new ServerReaderWriter(args,p,tab);
                        Thread t2 = new Thread(sec2);
                        t2.start();
                    }  
                }    
            } 
        }
        catch (Exception ex) {
            System.out.println("Excecao no arrancar do leitor UDP");
            System.out.println(ex.getStackTrace());
        }   
    }
}