import java.awt.Graphics;
import java.awt.Rectangle;

/* This class contains the size of the shape and the topLeft coordinate of the object which is of type Point 
and methods to change and get values of the Shape. */
public abstract class Shape {

    private Point topLeft;
    private int size;

    /** 
    * A constructor requiring the location of the top left point of the shape and its desired size.
    * @param  newTopLeftPoint
	* @param  newSize
    */
    public Shape(Point newTopLeftPoint, int newSize) {
        topLeft = new Point(newTopLeftPoint.getXCoord(), newTopLeftPoint.getYCoord());
        size = newSize;
    }
	/** 
    * A method returning a copy of the shape's top left point.
    */
    public Point getTopLeft() {
        return new Point(topLeft.getXCoord(), topLeft.getYCoord());
    }
	/** 
    * Retrieves the current size of the shape.
	* @return the int size
    */
    public int getSize() {
        return size;
    }
	/** 
    * A method moving the selected object down on the board.
	* @param  amount  how far the shape is displaced down the board 
    */
    public void moveDown(int amount) {
        topLeft.moveDown(amount);
    }
    /** 
    * A method moving the selected object up on the board.
    * @param  amount  how far the shape is displaced up the board
    */
    public void moveUp(int amount) {
        topLeft.moveUp(amount);
    }
    /** 
    * A method moving the selected object left on the board.
    * @param  amount  how far the shape is displaced left on the board
    */
    public void moveLeft(int amount) {
        topLeft.moveLeft(amount);
    }
	/** 
    * A method moving the selected object right on the board.
    * @param  amount  how far the shape is displaced right on the board
    */
    public void moveRight(int amount) {
        topLeft.moveRight(amount);
    }
	/** 
    * A
    * @param  
    */
    public void draw(Graphics g) {
        
    }
}