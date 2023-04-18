package client;

import compute.Task;

import java.io.Serializable;
import java.util.ArrayList;

public class ZerosAndOnes implements Task<String>, Serializable {
    private String[] args;

    public ZerosAndOnes(String[] args){
        this.args = args;
    }

    @Override
    public String execute() {
        ArrayList<Integer> al0 = new ArrayList();//создане списка для 0
        ArrayList<Integer> al1 = new ArrayList();//создане списка для 1

        int number = 0;
        int sumOld=0;
        int sumEven=0;
        for (int i = 1; i < args.length; i++) {
            try {
                number = Integer.parseInt(args[i]);
            } catch (Exception ex) {
                System.out.println("Letter entered! Enter 0 or 1");
                return null;
            }
            if (number % 2 != 0) {
                if(number < 0) {
                    sumEven += number;
                }
            } else {
                if(number > 0)
                    sumOld+=number;
            }
            System.out.println(sumOld);
            System.out.println(sumEven);
        }



        return "al0";
    }
}
