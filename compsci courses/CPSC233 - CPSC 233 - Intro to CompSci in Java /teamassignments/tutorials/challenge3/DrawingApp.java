import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.ArrayList;

import javax.swing.JFrame;
import javax.swing.Timer;

import java.util.Random;

/** 
 * Application for drawing shapes on the screen.  When the user click, a circle
 * will be created on the spot of default size.  When dragging the mouse, the circle
 * will have the size indicated by the drag area.
 * @author Nathaly Verwaal
 *
 */
public class DrawingApp extends JFrame implements KeyListener {
	public static final int WINDOW_WIDTH = 1000;
	public static final int WINDOW_HEIGHT = 1000;
	public static final int DEFAULT_CIRCLE_SIZE = 100;
	public static final int DEFAULT_SQUARE_SIZE = 60;
	
	private ArrayList<Shape> shapes = new ArrayList<Shape>();
	   
    /** 
     * Creates the window that users can use to draw shapes.
     */
    public DrawingApp() {
        setSize(WINDOW_WIDTH, WINDOW_HEIGHT);
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        getContentPane().addKeyListener(this);
        getContentPane().setFocusable(true); 
        requestFocusInWindow();
        
        Timer timer = new Timer(200,
            new ActionListener() {
                public void actionPerformed(ActionEvent e) {
                    timerAction();
                }
            });
        timer.setInitialDelay(1000);
        timer.start();
    }
    
	/**
	 * This method will move all shapes in our list down and ask the frame to
	 * be re-drawn whenever the timer goes off.
	 */
    public void timerAction(){
		for (Shape s : shapes) {
			s.moveDown(10);
		}
		repaint();
    }

    /**
    * 
    */
    
	@Override
    public void paint(Graphics canvas) {
        super.paint(canvas);

        for (Shape s : shapes) {
        	s.draw(canvas);
        }
    }
    
	@Override
	public void keyTyped(KeyEvent event) {
	}

	@Override
	public void keyPressed(KeyEvent e) {
		int size = 50;
		switch (e.getKeyCode()) {
		case 'C':
			Circle circ = new Circle(new Point(new Random().nextInt(WINDOW_WIDTH),new Random().nextInt(WINDOW_HEIGHT)), DEFAULT_CIRCLE_SIZE);
			shapes.add(circ);
			break;
		case 'S':
			Square square = new Square(new Point(new Random().nextInt(WINDOW_WIDTH),new Random().nextInt(WINDOW_HEIGHT)), DEFAULT_SQUARE_SIZE);
			shapes.add(square);
			break;
		case KeyEvent.VK_LEFT:
			for (Shape s : shapes) {
				s.moveLeft(5);
			}
			break;
		case KeyEvent.VK_RIGHT:
			for (Shape s : shapes) {
				s.moveRight(5);
			}
			break;
		case KeyEvent.VK_UP:
			for (Shape s : shapes) {
				s.moveUp(5);
			}
		case KeyEvent.VK_DOWN:
			for (Shape s : shapes) {
				s.moveDown(5);
			}
		}
			
	}

	@Override
	public void keyReleased(KeyEvent e) {	
	}

	/**
	*
	*/
    public static void main(String[] args) {
        javax.swing.SwingUtilities.invokeLater(new Runnable() {
            public void run() {
				DrawingApp faceWindow = new DrawingApp();
				faceWindow.setVisible(true);
			}
		});
    }

}