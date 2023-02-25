package program;
import java.io.*;
import exceptions.ArrayEqualElementsException;
import exceptions.ArrayLessElementsException;
import exceptions.ArrayMoreThanNumberElementsException;
import observer.HandelObserver;
import observer.OHandelObservable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.*;


public class Main {
    public static void main(String[] args) throws IOException {
        System.out.println("Please, enter a path to file: ");

        ///  /Users/macbookair/university/java/lab3/input.txt
        BufferedReader reader = new BufferedReader(
                new InputStreamReader(System.in));
        String fileName;
        fileName = reader.readLine();
        String[] numbers;
        try (Scanner fileScanner = new Scanner(new File(fileName))) {
            String[] inputNumbers = fileScanner.nextLine().split(" ");
            numbers = new String[inputNumbers.length];
            for (int i = 0; i < inputNumbers.length; i++) {
                numbers[i] = inputNumbers[i];
            }

        } catch (FileNotFoundException e) {
            System.out.println("Файл не найден!$e");
            System.out.println(e);
            return;
        }

        OHandelObservable oHandelObservable =new OHandelObservable();
        HandelObserver handelObserver =new HandelObserver();


        HandlingArray handlingArray = new HandlingArray();
        ArrayList<Integer> list;
        try {
            list = handlingArray.processParameters(numbers);

            oHandelObservable.addObserver(handelObserver);
            oHandelObservable.setArrayList(list);


        } catch (ArrayLessElementsException | ArrayMoreThanNumberElementsException | ArrayEqualElementsException e) {
            System.out.println(e);
            return;
        }

        HandlerLogicTask handlerLogicTask = new HandlerLogicTask();
        handlerLogicTask.setArray(handelObserver.getArrayList());
        handlerLogicTask.handelLogicTask();
        handlerLogicTask.sumEven();
        handlerLogicTask.sumOld();
    }
}

