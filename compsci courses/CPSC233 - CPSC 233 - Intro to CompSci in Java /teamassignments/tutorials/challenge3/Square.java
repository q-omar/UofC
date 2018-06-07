import java.awt.Graphics;
import java.awt.Rectangle;

/* This class' parent class is shape
/* This class contains a draw method and constructor for type square. */
public class Square extends Shape {
	
	 /**
    * A constructor for the Square class. Creates a new Shape with the specified values.
    * @param  newTopLeftPoint  a Point object with new coordinates for the square's top left point
	* @param  newSize          an integer describing the new size of the object square
    */
    public Square(Point newTopLeftPoint, int newSize) {
        super(newTopLeftPoint, newSize);
    }
	
	/**
    * A method for the Circle class which draws a circle/oval with the given values.
    * @param  Graphics g  an 
    */
    public void draw(Graphics g) {
    	g.drawRect(getTopLeft().getXCoord(), getTopLeft().getYCoord(), 
				getSize() * 2, 
				getSize() * 2);
    }

    
}