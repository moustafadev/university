



import fileWriter.WriterToTXTFile;

import java.io.*;
import java.net.*;

public class TCPServer {
//    private static final int PORT = 8000;

    public static void main(String[] args) {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
//            System.out.println("Please write the port:");
////            InetAddress SERVER_IP ;
////            SERVER_IP = InetAddress.getByName(reader.readLine());
//            int PORT;
//            PORT = Integer.parseInt(reader.readLine());
//            String path;
//            path = reader.readLine();
            GreetingServer greetingServer = new GreetingServer(Integer.parseInt(args[0]),args[1]);
            greetingServer.run();
            Thread t= new Thread (greetingServer,"thread");//Второй способ создания потока(Шаг.2) a.start();//Запуск потоков А
            greetingServer.start();
            t.start();

        } catch (IOException e) {
            System.out.println("Server error: " + e.getMessage());
        }
    }


}
