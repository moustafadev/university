package task.interfaces;

import task.exceptions.ArrayEqualElementsException;
import task.exceptions.ArrayLessElementsException;
import task.exceptions.ArrayMoreElementsException;

import java.util.ArrayList;

public interface IHandlingArrayException {

    ArrayList<Integer> processParameters(String[] args) throws ArrayMoreElementsException, ArrayEqualElementsException, ArrayLessElementsException;
}
