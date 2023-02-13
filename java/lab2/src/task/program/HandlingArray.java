package task.program;

import task.exceptions.ArrayEqualElementsException;
import task.exceptions.ArrayMoreThanNumberElementsException;
import task.exceptions.ArrayLessElementsException;
import task.interfaces.IHandlingArrayException;
import task.interfaces.IParameters;

import java.util.ArrayList;

public class HandlingArray implements IHandlingArrayException, IParameters {
    @Override
    public ArrayList<Integer> processParameters(String[] args) throws ArrayLessElementsException, ArrayEqualElementsException, ArrayMoreThanNumberElementsException {
        if(args.length < numberOfParameter){
            throw new ArrayLessElementsException();
        }
        if(args.length == numberOfParameter){
            throw new ArrayEqualElementsException();
        }

        ArrayList<Integer> arrayList = new ArrayList();
        for(String item : args){
            if(Integer.parseInt(item) > numberOfParameter){
                throw new ArrayMoreThanNumberElementsException();
            }
            arrayList.add(Integer.parseInt(item));
        }

        return arrayList;
    }
}
