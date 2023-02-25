package observer;


import java.util.ArrayList;
import java.util.Observable;

public class OHandelObservable extends Observable {
    public ArrayList<Integer> arrayList;

    public void setArrayList(ArrayList<Integer> arrayList) {
        this.arrayList = arrayList;
        setChanged();
        notifyObservers(arrayList);
    }
}