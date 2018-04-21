import java.awt.Graphics;
import java.awt.Rectangle;

/* This class' parent class is shape
/* This class contains a draw method and constructor for type circle. */
public class Circle extends Shape {
	 /**
    * A constructor for the Circle class. Creates a new Shape with the specified values.
    * @param  newTopLeftPoint  a Point object with new coordinates for the circle's top left point
	* @param  newSize          an integer describing the new size of the object circle
    */
    public Circle (Point newTopLeftPoint, int newSize) {
        super(newTopLeftPoint, newSize);
    }
	 /**
    * A method for the Circle class which draws a circle/oval using
    * @param  Graphics g  an 
    */
	public void draw(Graphics g){
		g.drawOval(getTopLeft().getXCoord(), getTopLeft().getYCoord(), 
				getSize() * 2, 
				getSize() * 2);
	}
}
