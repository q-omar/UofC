import java.util.Scanner;
import java.io.*;

public class TextFilesExample {
	public static void usingScanner() {
		try {
			Scanner reader = new Scanner(new File("TextFilesExample.java"));
			while (reader.hasNext()) {
				String line = reader.nextLine();
				System.out.println(line);
			}
			reader.close();
		} catch (FileNotFoundException fnfe) {
			fnfe.printStackTrace();
		}
	}
	
	public static void usingBufferedReader(){
		try {
			BufferedReader reader = new BufferedReader(new FileReader("TextFilesExample.java"));
			String line = reader.readLine();
			while (line != null) {
				System.out.println(line);
				line = reader.readLine();
			}
		} catch (FileNotFoundException fnfe) {
			fnfe.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();

		}
	}
	
	
	public static void main(String[] args) {
		//usingScanner();
		usingBufferedReader();
	}
}