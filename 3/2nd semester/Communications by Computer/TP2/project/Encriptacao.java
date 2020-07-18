import java.util.Arrays;
import static java.lang.System.out;

public class Encriptacao {

    public static int sizeof(byte[] array){
        return array.length;
    }

    public static byte[] repeat(byte[] pw, int len){
        int pwLen = pw.length;
        byte[] pad = new byte[len];
        
        for (int i = 0; i < len; i++) {
            if (i > 0) pad[i] = pw[i%pwLen];
            else pad[i] = pw[i];
        }
        return pad;
    }

    public static byte[] copyBytes(byte[] copyFrom, byte[] copyTo, int iinit, int jinit, int limit){
        for (int i=iinit, j=jinit, k=0; k++<limit; i++, j++)
            copyTo[j] = copyFrom[i];
        return copyTo;
    }

    public static byte[] shiftBytes(byte[] pad, int iinit, int jinit, int limit, int sentido){
        for (int i=iinit, j=jinit, k=0; k++<limit; i+=sentido, j+=sentido)
            pad[i] = pad[j];
        return pad;
    }

    public static byte[] rotate(byte[] pad, int key1, int len){
        if (key1 > 0) {
            int nbytes = key1%len;
            byte[] temp = new byte[nbytes];

            temp = copyBytes(pad, temp, len-nbytes, 0, nbytes);
            pad = shiftBytes(pad, len-1, len-1-nbytes, len-nbytes, -1);
            pad = copyBytes(temp, pad, 0, 0, nbytes);
        }
        if (key1 < 0) {
            int nbytes = Math.abs(key1)%len;
            byte[] temp = new byte[nbytes];
            
            temp = copyBytes(pad, temp, 0, 0, nbytes);
            pad = shiftBytes(pad, 0, nbytes, len-nbytes, 1);
            pad = copyBytes(temp, pad, 0, len-nbytes, nbytes);
        }
        return pad;
    }

    public static byte[] xor(byte[] pad, byte[] data, int len){
        byte[] xorArray = new byte[len];
        for (int i = 0; i < len; i++) {
            xorArray[i] = (byte) (pad[i] ^ data[i]);
        }
        return xorArray;
    }

    public static byte[] f(byte[] data, byte[] pw, int key1, int key2, String direction){
        int len = sizeof(data);
        byte[] pad = repeat(pw,len);
        pad = rotate(pad,key1,len);

        if (direction.equals("ENCRYPT")) data = rotate(data,key2,len);
        else data = rotate(data,-(key1+key2),len);

        byte[] r = xor(pad,data,len);

        if (direction.equals("ENCRYPT")) r = rotate(r,key1+key2,len);
        else r = rotate(r,-key2,len);

        return r;
    }

    public static byte[] encriptar(byte[] data, byte[] pw, int key1, int key2){
        return f(data,pw,key1,key2,"ENCRYPT");
    }

    public static byte[] desencriptar(byte[] data, byte[] pw, int key1, int key2){
        return f(data,pw,key1,key2,"DECRYPT");
    }

    public static void print(byte[] array){
        out.println(Arrays.toString(array));
    }
}
