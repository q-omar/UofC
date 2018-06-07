import java.util.Random;
import java.util.Scanner;


public class GuessingGame {

	public void play() {
		/* When called, plays one round of the guessing game by generating a random number
		for the user to guess. */

		int numberToGuess = new Random().nextInt(10) + 1; //computer generated number to guess 

		// printing the number to guess and inputting it into the checkGuess method
		System.out.println(numberToGuess);
		checkGuess(numberToGuess);
	}
	
	public boolean allDigits(String aString) {
		// this method takes the input type string and checks it for digits
		// Returns true if the string contains only digits and false if there is a non-digit character
		boolean noDigits = true;
		for (int index = 0; index < aString.length() && noDigits; index++){
			char aChar = aString.charAt(index);
			if (!Character.isDigit(aChar)){
				noDigits = false;
			
			}
		}
		return noDigits;
	}

	public void checkGuess(int numberToGuess) {
		// this method takes in the numberToGuess type int and prompts the user to guess
		// that number. Returns nothing.

		Scanner keyboard = new Scanner(System.in);
		
		// returning boolean win, if true it breaks the while loop
		boolean win = false;
		while (!win){//this will prompt user to continue inputing guesses until correct
			System.out.print("Enter your guess: ");//input prompt
			String guessAsString = keyboard.next();
			if (allDigits(guessAsString)){// checks if string has digits (only digits)
				int guess = Integer.parseInt(guessAsString);//converts from string to int				
				if (1 <= guess && guess <= 10){ // int must be between 1-10 inclusive
					System.out.println("valid guess");
				} else {
					System.out.println("not valid");// if not valid user is prompted again
				}
			
				if (guess < numberToGuess) { // conditional check of int guess against int numbertoguess
					System.out.println("Too low");
				} else if (guess > numberToGuess) {
					System.out.println("Too high");
				} else {
					System.out.println("You guessed it.");
					win = true;// boolean win returns true if valid/correct and breaks loop
				}
	
			} else {
				System.out.println("NOT A NUMBER!!!!");
			}
		}
	}	
}