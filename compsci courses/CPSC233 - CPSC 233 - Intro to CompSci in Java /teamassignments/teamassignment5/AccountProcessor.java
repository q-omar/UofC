import java.io.*;

class AccountProcessor{
	
	private String startBalance;
	
	String usingBufferedReader(){
        try {
			File file = new File("accountInfo.txt");
			file.createNewFile();//if a file accountInfo does not exist, creates one
			BufferedReader reader = new BufferedReader(new FileReader("accountInfo.txt"));
			String line;
			
			if (file.length() == 0) { //if file does not exist basically, makes the balance 0
				line = "0.0";
				System.out.println("No file found, creating new accountInfo"); //debugging msg
			} else{
				line = reader.readLine();
			}
			startBalance = line;
			while (line != null) {
				System.out.println("Reading start balance: "+line); //echoing line to console for debugging
				line = reader.readLine();
			}
		} catch (IOException ioe) {
			ioe.printStackTrace();

		}
		return startBalance;
	}

	
	void usingBufferedWriter(String endBalance){
		try {
			BufferedWriter writer = new BufferedWriter(new FileWriter("accountInfo.txt")); //writes to the accountInfo file
			writer.write(endBalance);//writes the new balance that was passed as a parameter
			System.out.println("Writing end balance: "+endBalance);//echoing line to console for debugging
			writer.close();
		} catch (IOException ioe) {
			ioe.printStackTrace();

		}
	
    }
}