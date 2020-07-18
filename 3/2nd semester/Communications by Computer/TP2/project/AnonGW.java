/**
 * Responsavel por ligar os seus leitores TCP e UDP, ambos threads.
 */
public class AnonGW{
    public static void main(String[] args){   
        Tabela tab = new Tabela();
        Arguments arg = new Arguments(args);
        
        TCPWorker prim = new TCPWorker(tab,arg); 
        Thread t1 = new Thread(prim);  
        t1.start();
                              
        UDPWorker sec = new UDPWorker(tab,arg); 
        Thread t2 = new Thread(sec);   
        t2.start();
    }   
}