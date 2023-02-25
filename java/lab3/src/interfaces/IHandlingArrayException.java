package interfaces;


import exceptions.ArrayEqualElementsException;
import exceptions.ArrayLessElementsException;
import exceptions.ArrayMoreThanNumberElementsException;

import java.util.ArrayList;

public interface IHandlingArrayException {
    ArrayList<Integer> processParameters(String[] args) throws ArrayLessElementsException, ArrayEqualElementsException, ArrayMoreThanNumberElementsException;
}
