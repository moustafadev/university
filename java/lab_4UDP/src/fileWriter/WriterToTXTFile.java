package fileWriter;


import java.io.*;

public class WriterToTXTFile implements IWriterToFile {
    public String fileName;


    public WriterToTXTFile(String fileName) {
        this.fileName = fileName;
    }


    @Override
    public void writeToFile(String data) {
        File file = new File(fileName);
        try {
            if (!file.exists())
                file.createNewFile();
            FileWriter writer = new FileWriter(fileName, true);
            BufferedWriter bw = new BufferedWriter(writer);
            try {
                bw.write(data);
            } finally {
                bw.close();
            }
        } catch (IOException e) {
            System.out.println(e);
            throw new RuntimeException("Error while writing data to file!");
        }
    }

    @Override
    public String reedToFile() throws IOException {
        try {
            FileReader fileReader = new FileReader(fileName);
            BufferedReader bufferedReader = new BufferedReader(fileReader);

            String line;
            while ((line = bufferedReader.readLine()) != null) {
                return line;
            }

            bufferedReader.close();
            fileReader.close();
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }
        return "";
    }
}
