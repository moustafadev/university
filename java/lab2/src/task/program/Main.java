package task.program;

import task.exceptions.ArrayEqualElementsException;
import task.exceptions.ArrayLessElementsException;
import task.exceptions.ArrayMoreElementsException;
import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        HandlingArray handlingArray = new HandlingArray();
        String[] s = new String[0];
        s = new String[]{"1","2"};
        ArrayList<Integer> list;
        try {
            list = handlingArray.processParameters(args);
        } catch (ArrayMoreElementsException | ArrayLessElementsException | ArrayEqualElementsException e) {
            System.out.println(e);
            return;
        }

        for (Object o : list) System.out.print(o + " ");

    }
}

