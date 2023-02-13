import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        int sumOld=0;
        int sumEven=0;
        for(String item : args){
            int number = Integer.parseInt(item);
            if (number % 2 != 0) {
                if(number < 0) {
                    sumEven += number;
                }
            } else {
                if(number >0)
                    sumOld+=number;
            }
        }
        System.out.println(sumOld);
        System.out.println(sumEven);
    }
}