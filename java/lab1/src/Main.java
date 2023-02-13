import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        ArrayList<Integer> arrOld = new ArrayList<>();
        ArrayList<Integer> arrEven = new ArrayList<>();
        for(int i=0;i<args.length;i++){
            int number = Integer.parseInt(args[i]);
            if (number % 2 == 0) {
                if(number >0)
                    arrOld.add(number);
            } else {
                if(number < 0)
                    arrEven.add(number);
            }
        }
        System.out.println("чётных и положительных"+arrOld);
        System.out.println("нечётных и отрицательных" +arrEven);
    }
}