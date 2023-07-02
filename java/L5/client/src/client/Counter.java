package client;

import compute.Task;
import java.io.Serializable;

public class Counter implements Task<Integer>, Serializable {

	private String[] args;

	public Counter(String[] args) {
		this.args = args;
	}

    public String execute() {
        int evenAndPositive = 0;
        int oddAndNegative = 0;

        int n = args.length;

        for (int i = 0; i < n-1; i++) {
            System.out.println(args[i]);
            if ( Integer.parseInt(args[i]) % 2 == 0) {
                evenAndPositive++;
            }
            else if (Integer.parseInt(args[i]) % 2 != 0) {
                oddAndNegative++;
            }
        }

        // Вывод
        return ("nech" + oddAndNegative + "\n" + "chet"  + evenAndPositive);
    }
	
}
