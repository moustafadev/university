package task.program;

import task.exceptions.ArrayEqualElementsException;
import task.exceptions.ArrayLessElementsException;
import task.exceptions.ArrayMoreElementsException;
import task.interfaces.IHandlingArrayException;
import task.interfaces.IParameters;

import java.util.ArrayList;

public class HandlingArray implements IHandlingArrayException, IParameters {
    @Override
    public ArrayList<Integer> processParameters(String[] args) throws ArrayMoreElementsException, ArrayEqualElementsException, ArrayLessElementsException {
        if(args.length > numberOfParameter){
            throw new ArrayMoreElementsException();
        }
        if(args.length == numberOfParameter){
            throw new ArrayEqualElementsException();
        }

        if(args.length < numberOfParameter){
            throw new ArrayLessElementsException();
        }
        ArrayList<Integer> arrayList = new ArrayList();
        for(String item : args){
            arrayList.add(Integer.parseInt(item));
        }

        return arrayList;
    }
}
