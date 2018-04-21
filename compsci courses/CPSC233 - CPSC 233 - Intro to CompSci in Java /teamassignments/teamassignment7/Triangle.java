/**
 * This class extends Shape. Allows one to create a Triangle object and obtain its area.
 */
public class Triangle extends Shape {
    
    /**
     * A constructor requiring 3 lines as parameters.
     * 
     * @param  line1  the first line of the triangle
     * @param  line2  the second line of the triangle
     * @param  line3  the third line of the triangle
     */
    public Triangle(Line line1, Line line2, Line line3) {
        addLine(line1);
        addLine(line2);
        addLine(line3);
    }
    
    /**
     * A getter method for the area of this triangle, calculated using Heron's Formula.
     * 
     * @return  the area of this triangle
     */
    public double getArea() {
        
        double halfCirc = getCircumference()/2;
        double length1 = getLines().get(0).length();
        double length2 = getLines().get(1).length();
        double length3 = getLines().get(2).length();
        
        double term1 = halfCirc - length1;
        double term2 = halfCirc - length2;
        double term3 = halfCirc - length3;
        
        double area = Math.sqrt(halfCirc * term1 * term2 * term3);
        
        return area;
    }
}