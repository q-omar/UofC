//CPSC 331
//Safian Omar Qureshi
//ID 10086638
//Assignment 2 Part 2 Question 2

//The following class implements a method used recursively to evaluate a prefix expression

import java.util.Scanner;

public class Prefix {
    private static int result(String op,int first,int second) { //method to be called recursively
        switch (op) {
            case "+": return first + second;
            case "-": return first - second;
            case "/": return first / second;
            case "*": return first * second;

        }
        throw new RuntimeException("Unexpected operator");
    }
    private static boolean isOperator(String str){ //boolean method checking for operators
        if(str.equals("-")||str.equals("+")||str.equals("*")||str.equals("/"))
            return true;
        return false;
    }
    public static int evaluate(Scanner sc){

            if(!sc.hasNext())return 0;
            String symbol = sc.next();
            if(isOperator(symbol)) {
                int firstOperand = evaluate(sc);
                int secondOperand = evaluate(sc);
                return result(symbol,firstOperand,secondOperand); //calling method recursively to evaluate prefix expression
            }
            else {
                return Integer.parseInt(symbol);
            }

    }
}