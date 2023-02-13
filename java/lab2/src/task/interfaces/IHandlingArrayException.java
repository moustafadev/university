package task.interfaces;

import task.exceptions.ArrayEqualElementsException;
import task.exceptions.ArrayMoreThanNumberElementsException;
import task.exceptions.ArrayLessElementsException;

import java.util.ArrayList;

public interface IHandlingArrayException {

    ArrayList<Integer> processParameters(String[] args) throws ArrayLessElementsException, ArrayEqualElementsException, ArrayMoreThanNumberElementsException;
}
