import java.awt.*;
import java.awt.event.*;

import javax.swing.*; //import all swing packages
 
public class GuessingGameGUI extends JFrame implements ActionListener{
	private GuessingGame game = new GuessingGame();
	
	private JLabel msgLabel = new JLabel("I'm thinking of a number between 1 and 10.  Try to guess it.");
	private JTextField entry = new JTextField(20);

	public GuessingGameGUI() {
		super("Guessing Game");
        super.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		JPanel content = new JPanel();
				content.setLayout(new BoxLayout(content, BoxLayout.Y_AXIS));

				msgLabel.setAlignmentX(Component.CENTER_ALIGNMENT);
				content.add(msgLabel);

				entry.setAlignmentX(Component.CENTER_ALIGNMENT);
				content.add(entry);

				JButton guessBtn = new JButton("guess");
				guessBtn.setActionCommand("GUESS");
				guessBtn.addActionListener(this);
				guessBtn.setAlignmentX(Component.CENTER_ALIGNMENT);
				content.add(guessBtn);

				super.getContentPane().add(content);

			}

			public void actionPerformed(ActionEvent event) {
				if (event.getActionCommand().equals("GUESS")){
					String guess = entry.getText();
					String message = game.manageGuess(guess);
					msgLabel.setText(message);
				}
			}

			public static void main(String[] args) {
				javax.swing.SwingUtilities.invokeLater(new Runnable() {
					public void run() {
						GuessingGameGUI gui = new GuessingGameGUI();
						gui.pack();
				gui.setVisible(true);
            }
        });
    }
}