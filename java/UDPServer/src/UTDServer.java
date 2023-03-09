
import java.io.*;
import java.net.*;

public class UTDServer {

    public static void main(String[] argv) throws IOException {

        DatagramSocket serverSocket = new DatagramSocket(9876,InetAddress.getByName("192.168.1.100"));

// Receive data from clients
        byte[] receiveData = new byte[1024];
        DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
        serverSocket.receive(receivePacket);

// Get the data from the received packet
        String message = new String(receivePacket.getData(), 0, receivePacket.getLength());

// Print the message
        System.out.println("Received message: " + message);
    }
}
