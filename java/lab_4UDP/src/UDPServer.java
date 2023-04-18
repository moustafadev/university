import fileWriter.WriterToTXTFile;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.*;

public class UDPServer {
    static WriterToTXTFile writerToTXTFile;
    public static void main(String[] args) throws IOException {

        BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));
        String input = inFromUser.readLine();
        int port = Integer.parseInt(input);
        writerToTXTFile = new WriterToTXTFile("/Users/macbookair/university/java/lab_4UDP/src/serverb.txt");
        String clientLogFile = writerToTXTFile.reedToFile();
        System.out.println(clientLogFile);
        while (true){
            UDPRun server = new UDPRun(port,clientLogFile);
            server.run();
        }

    }
}

class UDPRun implements Runnable{
    private static final int BUFFER_SIZE = 30;
    private DatagramSocket socket;
    private InetAddress clientAddress;

    public UDPRun(int port,String fileName) {

        try {
            writerToTXTFile = new WriterToTXTFile(fileName);
            socket = new DatagramSocket(port);
        } catch (SocketException e) {
            e.printStackTrace();
        }
    }
    private int clientPort;

    static WriterToTXTFile writerToTXTFile;


    private void sendMessage(String message) throws IOException {
        byte[] buffer = message.getBytes();
        DatagramPacket packet = new DatagramPacket(buffer, buffer.length-1, clientAddress, clientPort);
        socket.send(packet);
        String logMessage = "Sent to " + clientAddress + ":" + clientPort + "Result: - " + message + "\n";
        System.out.println(logMessage);
        writerToTXTFile.writeToFile(logMessage);
        //Utils.writeToFile(clientLogFile, logMessage);
    }

    private double evaluateExpression(String expression) {
        // проверяем, что выражение заканчивается знаком "="


        // разбиваем выражение на операнды и операции
        String[] tokens = expression.split("(?<=\\d)(?=[+\\-])|(?<=[+\\-])(?=\\d)");

        // переменная для хранения текущего результата вычислений
        double result = 0;

        // переменная для хранения текущей операции
        char operator = '+';

        // проходимся по всем токенам выражения
        for (String token : tokens) {
            // определяем, является ли токен оператором или операндом
            if (token.matches("[+\\-]")) {
                operator = token.charAt(0);
            } else if (token.matches("\\d+(\\.\\d+)?")) {
                double operand = Double.parseDouble(token);
                // выполняем соответствующую операцию
                if (operator == '+') {
                    result += operand;
                } else if (operator == '-') {
                    result -= operand;
                }
            } else {
                throw new IllegalArgumentException("Invalid expression");
            }
        }

        return result;
    }

    @Override
    public void run() {
        byte[] buffer = new byte[BUFFER_SIZE];
        DatagramPacket packet = new DatagramPacket(buffer, BUFFER_SIZE);
        boolean running = true;

        while (running) {
            try {
                String message = "";
                String logMessage = "";
                socket.receive(packet);
                message+=new String(packet.getData(), 0, packet.getLength());
                clientAddress = packet.getAddress();
                clientPort = packet.getPort();
//                if(packet = new DatagramPacket(buffer, BUFFER_SIZE))
                logMessage = "Received from " + clientAddress + ":" + clientPort + " - " + message + "\n";
                System.out.println(logMessage);
                writerToTXTFile.writeToFile(logMessage);
                //Utils.writeToFile(clientLogFile, logMessage);

                message = message.substring(0, message.length() - 1);
                try {
                    double result = evaluateExpression(message);
                    String response = String.valueOf(result);
                    sendMessage(response);
                } catch (ArithmeticException e) {
                    sendMessage("Error: " + e.getMessage());
                } catch (NumberFormatException e) {
                    sendMessage("Error: Invalid input format");
                }
            } catch (IOException e) {
                e.printStackTrace();
                running = false;
            }
        }
    }
}