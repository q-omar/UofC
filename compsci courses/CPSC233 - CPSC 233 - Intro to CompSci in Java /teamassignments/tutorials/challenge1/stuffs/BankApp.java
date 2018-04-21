import java.awt.event.*;
import java.io.*;

/**
 * This is the controller class for a program that lets the user withdraw and deposit
 * funds from their bank account.
 */
public class BankApp implements ActionListener {
    private BankGUI gui;
    private BankAccount account;
    
    /**
     * The BankApp default constructor first attempts to read bank account information from a file,
     * and use that information to create a new account.
     * If the file does not exist, a new account with default values will be made and saved to a file.
     */
    public BankApp() {

        try {
            readInfo();
            
        // If there is an error, create a new account
        } catch (FileNotFoundException fnfe) {
            account = new BankAccount(0.0, new Customer("test", 1));
            gui = new BankGUI(this, "0.0");
            gui.setError("Account information missing or incomplete, creating new account.");
            
        } catch (IOException ioe) {
            account = new BankAccount(0.0, new Customer("test", 1));
            gui = new BankGUI(this, "0.0");
            gui.setError("IO Exception occurred, creating new account.");
        }
        
        // Attempt to write to the file
        try {
            writeInfo();
        } catch (IOException ioe) {
            gui.setError("IO Exception occurred when saving account info. No changes made.");
        }
        
        gui.pack();
        gui.setVisible(true);
    }
    
    /**
     * Reads bank account information from a file called "accountInfo.txt".
     * The bank account information should be stored as a single line in the format:
     * "<balance> <accountHolderName> <accountHolderID>"
     * 
     * @throws FileNotFoundException  if "accountInfo.txt" does not exist or is not in the right format
     * @throws IOException  if there is an input or output error
     */
    private void readInfo() throws FileNotFoundException, IOException {
    	
		File file = new File("accountInfo.txt");
		//if the file accountInfo.txt does not exist, creates it
		file.createNewFile();
        BufferedReader reader = new BufferedReader(new FileReader("accountInfo.txt"));
        
        // Check if the file is empty
        if (file.length() != 0) {
            String line = reader.readLine();
            String[] info = line.split(" ");
            
            // If the read line is in the correct format, create new account from the file
            if (info.length == 3) {
                double balance = Double.parseDouble(info[0]);
                String holderName = info[1];
                int holderID = Integer.parseInt(info[2]);
                
                account = new BankAccount(balance,new Customer(holderName,holderID));
                gui = new BankGUI(this, Double.toString(account.getBalance()));
                
            } else {
                reader.close();
                throw new FileNotFoundException();
            }

        } else {
            reader.close();
            throw new FileNotFoundException();
        }
        
        reader.close();
    }
    
    /**
     * Writes bank account information to the file "accountInfo.txt".
     * The bank account information should be stored as a single line in the format:
     * "<balance> <accountHolderName> <accountHolderID>"
     * @throws IOException  if there is an input or output error
     */    
    private void writeInfo() throws IOException{
        BufferedWriter writer = new BufferedWriter(new FileWriter("accountInfo.txt"));
        writer.write(account.getBalance() + " " + account.getAccountHolder().getName() + " " +
                account.getAccountHolder().getID());

        writer.close();
    }
    
    /**
     * Responds to the user depositing or withdrawing funds from the bank account.
     * Updates the bank account information and GUI based on the button pressed, and
     * saves the new information to "accountInfo.txt".
     * @param event the button-click event to be handled
     */
    public void actionPerformed(ActionEvent event){
        if (event.getActionCommand().equals("deposit")){
            double amount = Double.parseDouble(gui.getAmount());
            account.deposit(amount);
        } else if (event.getActionCommand().equals("withdraw")){
            double amount = Double.parseDouble(gui.getAmount());
            try {
                account.withdraw(amount);
            } catch (InsufficientFundsException ife) {
                gui.setError("Insufficient Funds in Account");
            }
        }
        
        gui.clear();
        gui.setBalance("" + account.getBalance());
        
        // Overwrite the account info after an action has occurred
        try {
            writeInfo();
        } catch (IOException ioe) {
            gui.setError("IO Exception occurred when saving account info. No changes made.");
        }
    }
    
    /**
     * The main method which launches the BankApp program.
     * @param args
     */
    public static void main(String[] args) {
        javax.swing.SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                BankApp app = new BankApp();
            }
        });
    }
}
