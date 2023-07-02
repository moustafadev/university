
import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String input = scanner.nextLine();
        String[] letters = input.split(" ");

        // Сортируем массив букв в порядке A, B, C, ..., Z
        Arrays.sort(letters);

        // Проверяем, можно ли расставить детей в ряд так, чтобы каждый из них знал все буквы алфавита от A до Z
        boolean possible = true;
        for (int i = 0; i < letters.length; i++) {
            if (!letters[i].contains(Character.toString((char) ('A' + i)))) {
                possible = false;
                break;
            }
        }

        // Выводим результаты
        if (possible) {
            System.out.println("YES");
            
            for (int i = 0; i < letters.length; i++) {
                int index = input.indexOf(letters[i]);
                System.out.print((index/2 + 1) + " ");
            }
        } else {
            System.out.println("NO");
        }
    }
}