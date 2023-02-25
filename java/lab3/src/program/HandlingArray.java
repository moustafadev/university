package program;


import exceptions.ArrayEqualElementsException;
import exceptions.ArrayLessElementsException;
import exceptions.ArrayMoreThanNumberElementsException;
import interfaces.IHandlingArrayException;
import interfaces.IParameters;

import java.util.ArrayList;

public class HandlingArray implements IHandlingArrayException, IParameters {
    @Override
    public ArrayList<Integer> processParameters(String[] args) throws ArrayLessElementsException, ArrayEqualElementsException, ArrayMoreThanNumberElementsException {
//        if(args.length < numberOfParameter){
//            throw new ArrayLessElementsException();
//        }


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
