public class Triangle {

	private Line line1;
	private Line line2;
	private Line line3;

	public Triangle(Line aline1, Line aline2, Line aline3){
		line1 = new Line(new Point(), new Point());
		line2 = new Line(new Point(), new Point());
		line3 = new Line(new Point(), new Point());

		line1 = aline1;
		line2 = aline2;
		line3 = aline3;
	}
	
	public Line getLine1(){
		return new Line(new Point(), new Point());
	}
	
	public Line getLine2() {
		return new Line(new Point(), new Point());
	}
	
	public Line getLine3() {
		return new Line(new Point(), new Point());
	}
	
	public double getCircumference() {

		double length1 = line1.length();
		double length2 = line2.length();
		double length3 = line3.length();
		double circumference = length1+length2+length3;

		return circumference; 
		

	}
	
	public double getArea(){
		double length1 = line1.length();
		double length2 = line2.length();
		double length3 = line3.length();
		double circumference = length1+length2+length3;
		
		double halfPerimeter = circumference/2;
		double radicand = halfPerimeter*((halfPerimeter - length1)*(halfPerimeter - length2)*(halfPerimeter - length3)); //herons formula
		double area = Math.sqrt(radicand);
		
		return area;
	}
	
}
