import java.io.*;
import java.net.*;

public class client {
    public static void main(String[] argv) throws IOException {

        DatagramSocket clientSocket = new DatagramSocket();

        // Send data to the server
        String message = "Hello from the client!";
        byte[] sendData = message.getBytes();
        InetAddress serverAddress = InetAddress.getByName("192.168.1.100");
        int serverPort = 9876;
        DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, serverAddress, serverPort);
        clientSocket.send(sendPacket);

        // Close the client socket
        clientSocket.close();
    }
}
