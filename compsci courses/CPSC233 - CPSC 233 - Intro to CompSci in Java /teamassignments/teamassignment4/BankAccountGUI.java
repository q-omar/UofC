import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

public class BankAccountGUI extends JFrame implements ActionListener{

    private BankAccount account = new BankAccount();
    private JLabel msgLabel = new JLabel("Current Balance: "+account.getBalance()); //message label
    private JTextField entry = new JTextField(20); //20 is abitrary, sets the textbox width, text entry label

    public BankAccountGUI() { //this is a constructor for the GUI object
        super("Bank Account"); //title of the frame
        super.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); //action of 'x' in the frame, in our case its close

        JPanel content = new JPanel(); //panel is inside the frame, panels are used to have multiple 'widgets'
        //displayed inside the frame
        content.setLayout(new BoxLayout(content, BoxLayout.Y_AXIS)); //we are telling the panel content to be boxlayout
        //it takes arguements the panel itself, content, and how to display it (in our case boxlayout, go down y axis)

        msgLabel.setAlignmentX(Component.CENTER_ALIGNMENT); //the message label will be centered
        content.add(msgLabel); //we are adding message label to the panel

        entry.setAlignmentX(Component.CENTER_ALIGNMENT); //telling text entry label to be center
        content.add(entry); //adding text entry label to the panel

        JButton withdrawBtn = new JButton("Withdraw"); //adding a withdraw button
        withdrawBtn.addActionListener(this); //adds an action to the button and passes itself as argument
        //when you add an actionlistener event, an accomodating method called actionperformed needs to be implemented

        withdrawBtn.setActionCommand("WITHDRAW"); //putting an action onto the button
        withdrawBtn.setAlignmentX(Component.CENTER_ALIGNMENT); //alignment
        content.add(withdrawBtn); //add the button onto the panel

        JButton depositBtn = new JButton("Deposit");
        depositBtn.addActionListener(this);
        depositBtn.setActionCommand("DEPOSIT");
        depositBtn.setAlignmentX(Component.CENTER_ALIGNMENT);
        content.add(depositBtn);

        super.getContentPane().add(content); //this adds the panel, content, to the frame so it uses super
        //it adds all the stuff thats on the panel itself (buttons, textboxes) and it adds that panel to frame

    }

    /**
     * method actionPerformed is part of ActionListener where this method is essentially looking at the
     * text field and taking the user input and calling methods from our BankAccount object and updating that
     * input to display it
     */
    public void actionPerformed(ActionEvent event) {
        if (event.getActionCommand().equals("WITHDRAW")){ //this checks the set actioncommand above with a getaction command
            //if set action command equals whatever, then it does the following
            String input = entry.getText(); //gets input as string
            double inputasDouble = Double.parseDouble(input); //parses input as double
            account.withdraw(inputasDouble); //now we call the deposit method from our bankaccount object and process it
            msgLabel.setText("Current balance: "+account.getBalance());//set the new label as the new balance
        } else if (event.getActionCommand().equals("DEPOSIT")) {
            String input = entry.getText();
            double depositAsDouble = Double.parseDouble(input);
            account.deposit(depositAsDouble);
            msgLabel.setText("Current balance: "+account.getBalance());
        }
    }

    /**
     * method actionPerformed is part of ActionListener where this method is essentially looking at the
     * text field and taking the user input and calling methods from our BankAccount object and updating that
     * input to display it
     */

    public static void main(String[] args) {
        javax.swing.SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                BankAccountGUI gui = new BankAccountGUI();
                gui.pack();
                gui.setVisible(true);
            }
        });
    }
}