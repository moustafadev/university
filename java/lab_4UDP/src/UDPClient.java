import fileWriter.WriterToTXTFile;

import java.io.*;
import java.net.*;

public class UDPClient {

    public static void main(String args[]) throws Exception {

        if (args.length != 3) {
            System.out.println("Usage: java UDPClient <server_hostname> <server_port> <client_log_path>");
            return;
        }

        String serverHostname = args[0];
        int serverPort = Integer.parseInt(args[1]);
        String clientLogPath = args[2];

        BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));

        DatagramSocket clientSocket = new DatagramSocket();

        WriterToTXTFile writerToTXTFile = new WriterToTXTFile(clientLogPath);

        InetAddress IPAddress = InetAddress.getByName(serverHostname);

        byte[] sendData;
        byte[] receiveData = new byte[24];

        String expression = "";

        while (true) {
            String input = inFromUser.readLine();
            if (input.equals("exit")) {
                break;
            }

            expression += input;
            sendData = expression.getBytes();
            DatagramPacket sendPacket;
            final int PACKET_SIZE = 24;

            int index = 0;
            while (index < expression.length()) {
                String subExpression = expression.substring(index, Math.min(index + PACKET_SIZE, expression.length()));
                sendData = subExpression.getBytes();
                sendPacket = new DatagramPacket(sendData, sendData.length, IPAddress, serverPort);
                clientSocket.send(sendPacket);
                index += PACKET_SIZE;
            }
            DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
            clientSocket.receive(receivePacket);
            if (input.endsWith("=")) {

                String result = new String(receivePacket.getData(), 0, receivePacket.getLength());

                System.out.println("Result: " + result);


                // Writing server response to client log file
                writerToTXTFile.writeToFile("Result: " + result + "\n");


                expression = "";
            }
        }

        clientSocket.close();
    }
}


