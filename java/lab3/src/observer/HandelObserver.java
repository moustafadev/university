package observer;

import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;

public class HandelObserver implements Observer {

    public ArrayList<Integer> arrayList;

    public void setArrayList(ArrayList<Integer> arrayList){
        this.arrayList = arrayList;
    }

    public ArrayList<Integer> getArrayList(){
        return  this.arrayList;
    }
    @Override
    public void update(Observable o, Object arg) {
        System.out.println(arg);
        setArrayList((ArrayList<Integer>) arg);
    }
}
