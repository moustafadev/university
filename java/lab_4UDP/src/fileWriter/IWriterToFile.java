package fileWriter;

import java.io.IOException;

public interface IWriterToFile {
    void writeToFile(String data);
    String reedToFile() throws IOException;
}
