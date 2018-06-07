import java.util.ArrayList;

/** 
 * This abstract class contains an array of lines that form a shape and methods
 * to manipulate and obtain information about the shape.
 */
public abstract class Shape {
    private ArrayList<Line> lines = new ArrayList<Line>();
    
    /** 
     * Adds a new line to to the shape. If the reference to aLine is added directly to the lines ArrayList,
     * there will be a privacy leak, because the line can still be manipulated outside of Shape.
     * Thus, aLine must be copied before being added to the list, so only Shape has access to the new reference.
     * 
     * @param  aLine  the next line to be added, which must begin where the shape's last line ended
     */
    protected void addLine(Line aLine) {
        
        if (lines.isEmpty()) {
            lines.add(new Line(aLine.getStart(), aLine.getEnd()));
        } else {
            Point startPoint = aLine.getStart();
            Line lastLine = lines.get(lines.size()-1);
            Point lastEndPoint = lastLine.getEnd();
            
            if (lastEndPoint.equals(startPoint)) {
                lines.add(new Line(startPoint, aLine.getEnd()));
            }
        }
    }
    
    /** 
     * Abstract getter method for the shape's area.
     * 
     * @return  the area of the shape
     */
    public abstract double getArea();
    
    /**
     * A getter method for the lines ArrayList. This creates a privacy leak since it returns the original
     * reference to lines without making a copy. However, this privacy leak does not need to be prevented
     * since this method is protected, and Shape subclasses such as Triangle should have direct access to
     * their own lines.
     * 
     * @return  the ArrayList containing all lines in the shape
     */
    protected ArrayList<Line> getLines() {
        return lines;
    }
    
    /**
     * A getter method for the lines ArrayList. Returning a direct reference to lines would create a
     * privacy leak, which must be avoided since this method is public. Instead, a deep copy of lines
     * is created and returned.
     * 
     * @return  a copy of the ArrayList containing all lines in the shape
     */
    public ArrayList<Line> getShape() {
        ArrayList<Line> copyList = new ArrayList<Line>();
        for (Line l : lines) {
            copyList.add(new Line(l.getStart(), l.getEnd()));
        }
        return copyList;
    }
    
    /** 
     * A getter method for the circumference of the shape, which is the sum of the lengths of
     * all its lines.
     * 
     * @return  the circumference of the shape
     */
    public double getCircumference() {
        double circumference = 0;
        
        for (Line l : lines) {
            circumference += l.length();
        }
        return circumference;
    }
    
    /**
     * Returns a string representation of this shape, in the format
     * "[(line1_x1,line1_y1),(line1_x2,line1_y2)],[(line2_x1,line2_y1),(line2_x2,line2_y2)]..."
     * 
     * @return string representation of this shape.
     */
    @Override
    public String toString() {
        String allLines = "";
        
        for (int index = 0; index < lines.size(); index++) {
            if (index != lines.size()-1) {
                allLines += "[" + lines.get(index).toString() + "],";
            } else {
                allLines += "[" + lines.get(index).toString() + "]"; // If last line, do not add comma at end
            }
        }
        
        return allLines;
    }
    
}