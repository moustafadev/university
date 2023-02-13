package task.program;

import task.exceptions.ArrayEqualElementsException;
import task.exceptions.ArrayMoreThanNumberElementsException;
import task.exceptions.ArrayLessElementsException;
import java.util.ArrayList;


public class Main {
    public static void main(String[] args) {
        HandlingArray handlingArray = new HandlingArray();
        ArrayList<Integer> list;
        try {
            list = handlingArray.processParameters(args);
        } catch (ArrayLessElementsException | ArrayMoreThanNumberElementsException | ArrayEqualElementsException e) {
            System.out.println(e);
            return;
        }

        for (Object o : list) System.out.print(o + " ");

    }
}

