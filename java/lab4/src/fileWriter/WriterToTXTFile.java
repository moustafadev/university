package fileWriter;


import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class WriterToTXTFile implements IWriterToFile {
    private String fileName;


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
}
