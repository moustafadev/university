import java.util.HashMap;
import java.util.Stack;

public class SolveOperation {
    public int evaluate(String expression) {
        // Create a stack for holding operands
        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < expression.length(); i++) {
            // If the character is a space, skip it
            if (expression.charAt(i) == ' ')
                continue;

            // If the character is a digit, push it to the stack
            if (Character.isDigit(expression.charAt(i))) {
                int num = 0;
                // Extract the number from the string and push it to the stack
                while (Character.isDigit(expression.charAt(i))) {
                    num = num * 10 + (expression.charAt(i) - '0');
                    i++;
                }
                // Since i is incremented twice in a row here, decrement it to keep track of the last index seen
                i--;
                stack.push(num);
            } else {
                // If the character is not a digit, pop the two operands and perform the operation
                int op1 = stack.pop();
                int op2 = stack.pop();

                switch (expression.charAt(i)) {
                    case '+':
                        stack.push(op2 + op1);
                        break;
                    case '-':
                        stack.push(op2 - op1);
                        break;
                    default:
                        throw new IllegalArgumentException("Invalid operator");
                }
            }
        }
        // The final element on the stack is the result
        return stack.pop();
    }

}
