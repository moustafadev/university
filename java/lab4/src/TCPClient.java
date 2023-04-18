



import fileWriter.WriterToTXTFile;

import java.net.*;
import java.io.*;
import java.util.Scanner;

public class TCPClient {
//    private static final String SERVER_IP = "127.0.0.1";
//    private static final int SERVER_PORT = 8000;

    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        String path;
        System.out.println("Please write the port:");//6066/Users/macbookair/university/java/lab4/src/output.txt
        int SERVER_PORT = Integer.parseInt(String.valueOf(reader.readLine()));
        System.out.println("Please write the Address host:");//127.0.0.1
        InetAddress SERVER_IP = InetAddress.getByName(String.valueOf(reader.readLine()));
        System.out.println(SERVER_IP);
        System.out.println(SERVER_PORT);


        try (Socket socket = new Socket(SERVER_IP, SERVER_PORT);
             DataInputStream input = new DataInputStream(socket.getInputStream());
             DataOutputStream output = new DataOutputStream(socket.getOutputStream());
             ) {

            System.out.println("Please write the Path File:");//127.0.0.1
            path = String.valueOf(reader.readLine());
            WriterToTXTFile writerToTXTFile = new WriterToTXTFile(path);
            System.out.println("Connected to server: " + socket.getInetAddress());

            while (true) {
                System.out.println("Enter command (1: read, 2: write, 3: set default values, 4: get array size)");
                int action = Integer.parseInt(reader.readLine());

                if (action == 1) { // read cell value
                    output.writeInt(1);
                    System.out.println("Enter array type (0: integer, 1: double, 2: string):");
                    int arrayType = Integer.parseInt(reader.readLine());
                    output.writeInt(arrayType);
                    System.out.println("Enter row index:");
                    int row = Integer.parseInt(reader.readLine());
                    output.writeInt(row);
                    System.out.println("Enter column index:");
                    int col = Integer.parseInt(reader.readLine());
                    output.writeInt(col);

                    if (arrayType == 0) { // integer array
                        int value = input.readInt();
                        writerToTXTFile.writeToFile("Cell value: " + value);
                        System.out.println("Cell value: " + value+"\nDone written in File");
                    } else if (arrayType == 1) { // double array
                        double value = input.readDouble();
                        writerToTXTFile.writeToFile("Cell value: " + value);
                        System.out.println("Cell value: " + value+"\nDone written in File");
                    } else if (arrayType == 2) { // string array
                        String value = input.readUTF();
                        writerToTXTFile.writeToFile("Cell value: " + value);
                        System.out.println("Cell value: " + value+"\nDone written in File");
                    } else {
                        writerToTXTFile.writeToFile("Invalid array type.");
                        System.out.println("Invalid array type.");
                    }
                } else if (action == 2) { // write cell value
                    output.writeInt(2);
                    System.out.println("Enter array type (0: integer, 1: double, 2: string):");
                    int arrayType = Integer.parseInt(reader.readLine());
                    output.writeInt(arrayType);
                    System.out.println("Enter row index:");
                    int row = Integer.parseInt(reader.readLine());
                    output.writeInt(row);
                    System.out.println("Enter column index:");
                    int col = Integer.parseInt(reader.readLine());
                    output.writeInt(col);

                    if (arrayType == 0) { // integer array
                        System.out.println("Enter new cell value:");
                        int value = Integer.parseInt(reader.readLine());
                        output.writeInt(value);
                    } else if (arrayType == 1) { // double array
                        System.out.println("Enter new cell value:");
                        double value = Double.parseDouble(reader.readLine());
                        output.writeDouble(value);
                    } else if (arrayType == 2) { // string array
                        System.out.println("Enter new cell value:");
                        String value = reader.readLine();
                        output.writeUTF(value);
                    } else {
                        System.out.println("Invalid array type.");
                        continue;
                    }

                    String response = input.readUTF();
                    writerToTXTFile.writeToFile(response);
                    System.out.println(response+"\nDone written in File");
                } else if (action == 3) { // set default values
                    output.writeInt(3);
                    System.out.println("Enter default integer value:");
                    int intDefault = Integer.parseInt(reader.readLine());
                    output.writeInt(intDefault);
                    System.out.println("Enter default double value:");

                    double doubleDefault = Double.parseDouble(reader.readLine());
                    output.writeDouble(doubleDefault);
                    System.out.println("Enter default string value:");

                    String stringDefault = reader.readLine();
                    output.writeUTF(stringDefault);

                    String response = input.readUTF();
                    writerToTXTFile.writeToFile(response);
                    System.out.println(response +"\nDone written in File");
                } else if (action == 4) { // get array dimensions
                    output.writeInt(4);
                    System.out.println("Enter array type (0: integer, 1: double, 2: string):");
                    int arrayType = Integer.parseInt(reader.readLine());
                    output.writeInt(arrayType);
//                    System.out.println(input.readBoolean());
                    int rows = input.readInt();
                    int cols = input.readInt();
                    writerToTXTFile.writeToFile("Array dimensions: " + rows + " x " + cols);
                    System.out.println("Array dimensions: " + rows + " x " + cols+"\nDone written in File");
//                    if (input.readBoolean()) {
//                        int rows = input.readInt();
//                        int cols = input.readInt();
//                        System.out.println("Array dimensions: " + rows + " x " + cols);
//                    } else {
//                        System.out.println("Invalid array type.");
//                    }
                } else {
                    System.out.println("Invalid command.");
                }
            }
        } catch (IOException e) {
            System.out.println(e);
        }
    }
}
