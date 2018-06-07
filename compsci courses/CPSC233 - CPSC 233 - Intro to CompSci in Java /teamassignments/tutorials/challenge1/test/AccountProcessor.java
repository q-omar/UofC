import java.io.*;

public class AccountProcessor{

	private String startBalance;
	
	public String usingBufferedReader(){
        try {
			File file = new File("accountInfo.txt");
			file.createNewFile();//if a file accountInfo does not exist, creates one
			BufferedReader reader = new BufferedReader(new FileReader("accountInfo.txt"));
			String line;
			
			if (file.length() == 0) { //if file does not exist basically, makes the balance 0
				line = "Balance: 0.0";
				System.out.println("No text file, creating new accountInfo");
			} else{
			    line = reader.readLine();
			}

            int length = line.length();
			startBalance = line.substring(9,length);//extracting part of string: https://stackoverflow.com/questions/12581581/how-to-get-particular-part-of-string-in-java

			while (line != null) {
				System.out.println("Reading line: "+line); //echoing line to console for debugging
				line = reader.readLine();
			}

			reader.close();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
		return startBalance;
	}

	
	public void usingBufferedWriter(String endBalance, int customerID, String customerName, int bankID){
		try {
			BufferedWriter writer = new BufferedWriter(new FileWriter("accountInfo.txt")); //writes to the accountInfo file

            writer.write("Balance: "+endBalance+System.lineSeparator());
            writer.write("Bank ID: "+bankID+System.lineSeparator());
            writer.write("Customer name: "+customerName+System.lineSeparator());
            writer.write("Customer ID: "+customerID+System.lineSeparator());
            //writes parameters passed by bankapp to the txt file
			writer.close();
		} catch (IOException ioe) {
			ioe.printStackTrace();

		}
	
    }
}