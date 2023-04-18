import fileWriter.WriterToTXTFile;

public class PrintArray {

    private  WriterToTXTFile writerToTXTFile;
    PrintArray(WriterToTXTFile writer){
        this.writerToTXTFile = writer;
    }
     void printArrayInt(int[][] array) {
        for (int[] row : array) {
            for (int element : row) {
                System.out.print(element + " ");
                writerToTXTFile.writeToFile(element + " ");
            }
            writerToTXTFile.writeToFile("\n");
            System.out.println();
        }
         writerToTXTFile.writeToFile("\n");
        System.out.println();
    }
     void printArrayDouble(double[][] array) {
        for (double[] row : array) {
            for (double element : row) {
                System.out.print(element + " ");
                writerToTXTFile.writeToFile(element + " ");
            }
            writerToTXTFile.writeToFile("\n");
            System.out.println();
        }
         writerToTXTFile.writeToFile("\n");
        System.out.println();
    }
     void printArrayString(String[][] array) {
        for (String[] row : array) {
            for (String element : row) {
                System.out.print(element + " ");
                writerToTXTFile.writeToFile(element + " ");
            }
            writerToTXTFile.writeToFile("\n");
            System.out.println();
        }
         writerToTXTFile.writeToFile("\n");
        System.out.println();
    }
}
