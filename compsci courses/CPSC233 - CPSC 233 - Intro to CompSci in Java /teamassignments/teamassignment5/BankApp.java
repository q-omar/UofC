import java.awt.event.*;
import java.io.*;

public class BankApp implements ActionListener {
    private BankGUI gui;
    private BankAccount account;
    
    public BankApp() {
        
        // Attempt to read a file for account information.
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
        
        try {
            writeInfo();
        } catch (IOException ioe) {
            gui.setError("IO Exception occurred when saving account info. No changes made.");
        }
        
        gui.pack();
        gui.setVisible(true);
    }
    
    private void readInfo() throws FileNotFoundException, IOException {
    	
		File file = new File("accountInfo.txt");
		//if the file accountInfo does not exist, creates it
		file.createNewFile();
        
        BufferedReader reader = new BufferedReader(new FileReader("accountInfo.txt"));
        
        // Check if the file is empty
        if (file.length() != 0) {
            String line = reader.readLine();
            
            // Account info will be stored in one line, in the format: 
            // "<balance> <accountHolderName> <accountHolderID>"
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
    
    private void writeInfo() throws IOException{
        BufferedWriter writer = new BufferedWriter(new FileWriter("accountInfo.txt"));
        writer.write(account.getBalance() + " " + account.getAccountHolder().getName() + " " +
                account.getAccountHolder().getID());

        writer.close();
    }
    
    public void actionPerformed(ActionEvent event){
        if (event.getActionCommand().equals("deposit")){
            double amount = Double.parseDouble(gui.getAmount());
            account.deposit(amount);
        } else if (event.getActionCommand().equals("withdraw")){
            double amount = Double.parseDouble(gui.getAmount());
            try {
                account.withdraw(amount);
            } catch (Exception ife) {
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
    
    public static void main(String[] args) {
        javax.swing.SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                BankApp app = new BankApp();
            }
        });
    }
}
