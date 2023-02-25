package program;

import fileWriter.WriterToTXTFile;

import java.util.ArrayList;

public class HandlerLogicTask {

    private ArrayList<Integer> list;

    private int sumEven;
    private int sumOld;
    WriterToTXTFile writerToTXTFile = new WriterToTXTFile();

    public void setArray(ArrayList<Integer> list) {
        this.list = list;
    }

    public void handelLogicTask() {
        for (Integer number : list) {
            //assertThat("They are not equal!",number,is(2));
            if (number % 2 != 0) {
//                if(number < 0) {
                sumEven += number;

            } else {
                if (number > 0)
                    sumOld += number;
            }
        }
    }

    ///Users/macbookair/university/java/lab3/output.txt
    public void sumOld() {
        writerToTXTFile.writeToFile(String.valueOf(this.sumOld));
        System.out.println(this.sumOld);
    }

    public void sumEven() {
        writerToTXTFile.writeToFile(String.valueOf(this.sumEven));
        System.out.println(this.sumEven);
    }


}
