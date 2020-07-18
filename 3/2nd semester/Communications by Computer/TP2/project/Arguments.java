import java.util.*;

public class Arguments {
    private Map<String, List<String>> params;

    public Arguments(String... args){
        params = new HashMap<>();
        List<String> options = null;
        for (int i = 0; i < args.length; i++) {
            String a = args[i];

            if (a.charAt(0) == '-') {
                if (a.length() < 2) {
                    System.err.println("Error: arg " + a);
                    return;
                }
                options = new ArrayList<>();
                params.put(a.substring(1), options);
            }
            else if (options != null) {
                options.add(a);
            }
            else {
                System.err.println("Error: char " + a.charAt(0));
                return;
            }
        }
    }

    public List<String> getArgumentsOf(String arg){
        return params.get(arg);
    }

    public void printOut(){
        for(Map.Entry<String,List<String>> entry : params.entrySet()){
            System.out.println("Key: " + entry.getKey());
            System.out.print("Values: ");
            for(String s: entry.getValue()){
                System.out.println(s + ", ");
            }
        }
    }

    public int getPort(){
        return Integer.parseInt(this.params.get("port").get(0));
    }

    public List<String> getPeers(){
        return this.params.get("peers");
    }

    public String getTarget(){
        return this.params.get("target").get(0);
    }

    public int getKey1(){
        return Integer.parseInt(this.params.get("keys").get(0));
    }

    public int getKey2(){
        return Integer.parseInt(this.params.get("keys").get(1));
    }

    public byte[] getPassword(){
        return this.params.get("password").get(0).getBytes();
    }
}
