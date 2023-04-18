import fileWriter.WriterToTXTFile;

import java.io.*;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;

public class GreetingServer extends Thread {
    private ServerSocket serverSocket;

    WriterToTXTFile writerToTXTFile;
    private static final int ROWS = 10;
    private static final int COLS = 10;

    private static int[][] intData = new int[ROWS][COLS];
    private static double[][] doubleData = new double[ROWS][COLS];
    private static String[][] stringData = new String[ROWS][COLS];

    public GreetingServer(int port, String fileName) throws IOException {
        serverSocket = new ServerSocket(port);
        writerToTXTFile= new WriterToTXTFile(fileName);
        serverSocket.setSoTimeout(10000);
    }

    public void run() {
        PrintArray printArray = new PrintArray(writerToTXTFile);
        try {
            System.out.println("Server started on port " + serverSocket.getLocalPort());

            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("Client connected: " + clientSocket.getInetAddress());

                try (DataInputStream input = new DataInputStream(clientSocket.getInputStream());
                     DataOutputStream output = new DataOutputStream(clientSocket.getOutputStream())) {
                    while (true) {
                        int action = input.readInt();

                        if (action == 1) { // read cell value
                            int arrayType = input.readInt();
                            int row = input.readInt();
                            int col = input.readInt();

                            if (arrayType == 0) { // integer array
                                int value = intData[row][col];
                                output.writeInt(value);
                            } else if (arrayType == 1) { // double array
                                double value = doubleData[row][col];
                                output.writeDouble(value);
                            } else if (arrayType == 2) { // string array
                                String value = stringData[row][col];
                                output.writeUTF(value);
                            } else {
                                output.writeUTF("Invalid array type.");
                            }
                        } else if (action == 2) { // write cell value
                            int arrayType = input.readInt();
                            int row = input.readInt();
                            int col = input.readInt();

                            if (arrayType == 0) { // integer array
                                int value = input.readInt();
                                intData[row][col] = value;
                            } else if (arrayType == 1) { // double array
                                double value = input.readDouble();
                                doubleData[row][col] = value;
                            } else if (arrayType == 2) { // string array
                                String value = input.readUTF();
                                stringData[row][col] = value;
                            } else {
                                output.writeUTF("Invalid array type.");
                            }

                            System.out.println("Integer Array:");
                            printArray.printArrayInt(intData);
                            System.out.println("Double Array:");
                            printArray.printArrayDouble(doubleData);
                            System.out.println("String Array:");
                            printArray.printArrayString(stringData);

                            output.writeUTF("Cell value updated.");
                        } else if (action == 3) { // set default values
                            int intDefault = input.readInt();
                            double doubleDefault = input.readDouble();
                            String stringDefault = input.readUTF();

                            for (int i = 0; i < ROWS; i++) {
                                for (int j = 0; j < COLS; j++) {
                                    intData[i][j] = intDefault;
                                    doubleData[i][j] = doubleDefault;
                                    stringData[i][j] = stringDefault;
                                }
                            }

                            System.out.println("Integer Array:");
                            printArray.printArrayInt(intData);
                            System.out.println("Double Array:");
                            printArray.printArrayDouble(doubleData);
                            System.out.println("String Array:");
                            printArray.printArrayString(stringData);

                            output.writeUTF("Default values set.");
                        } else if (action == 4) { // get array dimensions
                            int arrayType = input.readInt();
                            if (arrayType == 0) { // integer array
                                output.writeInt(intData.length);
                                output.writeInt(intData[0].length);
                            } else if (arrayType == 1) { // double array
                                output.writeInt(doubleData.length);
                                output.writeInt(doubleData[0].length);
                            } else if (arrayType == 2) { // string array
                                output.writeInt(stringData.length);
                                output.writeInt(stringData[0].length);
                            } else {
                                output.writeUTF("Invalid array type.");
                            }
                        }
                    }
                } catch (IOException e) {
                    System.out.println("Client disconnected.");
                }
            }
        } catch (IOException e) {
            System.out.println("Server error: " + e.getMessage());
        }

    }


}
