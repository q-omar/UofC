import static org.junit.Assert.*;

import org.junit.Test;

public class TriangleTest{
    
	@Test
	public void test_Circumference_0() {
    	Line line1 = new Line(new Point(0,0), new Point(0,0));
    	Line line2 = new Line(new Point(0,0), new Point(0,0));
    	Line line3 = new Line(new Point(0,0), new Point(0,0));
        Triangle triangle1 = new Triangle(line1, line2, line3);
        double circumference =  triangle1.getCircumference();
		
        assertEquals("Testing circumference of triangle with all coordinates (0,0)", 0.0, circumference, 0.00001);
	}
	
    @Test
	public void test_Circumference_1() {
    	Line line1 = new Line(new Point(1,2), new Point(4,6));
    	Line line2 = new Line(new Point(5,2), new Point(4,6));
    	Line line3 = new Line(new Point(1,2), new Point(5,2));
    	
        Triangle triangle1 = new Triangle(line1, line2, line3);
        double circumference =  triangle1.getCircumference();
        
        assertEquals("Testing circumference of triangle with coordinates (1,2), (5,2), (4,6)", 13.12310 , circumference, 0.00001);
	}
    
	@Test
	public void test_Circumference_2() {
    	Line line1 = new Line(new Point(1,2), new Point(4,6));
    	Line line2 = new Line(new Point(2,4), new Point(4,6));
    	Line line3 = new Line(new Point(1,2), new Point(2,4));
    	
        Triangle triangle1 = new Triangle(line1, line2, line3);
        double circumference =  triangle1.getCircumference();
        
        assertEquals("Testing circumference of triangle with coordinates (1,2), (2,4), (4,6)", 10.06449 , circumference, 0.00001);
	}
	
	@Test
	public void test_Circumference_negative_values() {
    	Line line1 = new Line(new Point(-6,2), new Point(4,6));
    	Line line2 = new Line(new Point(2,4), new Point(4,6));
    	Line line3 = new Line(new Point(0,2), new Point(2,4));
    	
        Triangle triangle1 = new Triangle(line1, line2, line3);
        double circumference =  triangle1.getCircumference();
        
        assertEquals("Testing circumference of triangle with coordinates (-6,2), (2,4), (4,6)", 11.31370 , circumference, 0.00001);
	}
    
	@Test
	public void test_Circumference_not_triangle() {
    	Line line1 = new Line(new Point(2,1), new Point(3,4));
    	Line line2 = new Line(new Point(3,4), new Point(5,4));
    	Line line3 = new Line(new Point(5,4), new Point(4,2));
    	
        Triangle triangle1 = new Triangle(line1, line2, line3);
        double circumference =  triangle1.getCircumference();
        
        assertEquals("Testing circumference of triangle with coordinates (2,1),(3,4),(5,4) and (4,2)", 0.0 , circumference, 0.00001);
	}
	
	@Test
	public void test_Circumference_lines_equal() {
    	Line line1 = new Line(new Point(3,3), new Point(6,8));
    	Line line2 = new Line(new Point(6,8), new Point(3,3));
    	Line line3 = new Line(new Point(3,3), new Point(5,3));
    	
        Triangle triangle1 = new Triangle(line1, line2, line3);
        double circumference =  triangle1.getCircumference();
        
        assertEquals("Testing circumference of triangle with coordinates (3,3),(6,8),(5,3)", 0.0 , circumference, 0.00001);
	}
	
	@Test
	public void test_Circumference_lines_overlap() {
    	Line line1 = new Line(new Point(3,1), new Point(4,2));
    	Line line2 = new Line(new Point(3,1), new Point(5,3));
    	Line line3 = new Line(new Point(5,3), new Point(5,0));
    	
        Triangle triangle1 = new Triangle(line1, line2, line3);
        double circumference =  triangle1.getCircumference();
        
        assertEquals("Testing circumference of triangle with coordinates (3,1),(4,2),(5,3) and (5,0)", 0.0 , circumference, 0.00001);
	}
	
	@Test
	public void testArea_0() {
    	Line line1 = new Line(new Point(0,0), new Point(0,0));
    	Line line2 = new Line(new Point(0,0), new Point(0,0));
    	Line line3 = new Line(new Point(0,0), new Point(0,0));
        Triangle triangle1 = new Triangle(line1, line2, line3);
        
		double area = triangle1.getArea();
		
        assertEquals("Testing area of triangle with all coordinates (0,0)", 0.0, area, 0.00001);
    }
	
	@Test
	public void test_Area_1() {
    	Line line1 = new Line(new Point(1,2), new Point(4,6));
    	Line line2 = new Line(new Point(2,4), new Point(4,6));
    	Line line3 = new Line(new Point(1,2), new Point(2,4));
    	
        Triangle triangle1 = new Triangle(line1, line2, line3);
		double area = triangle1.getArea();
		
        assertEquals("Testing area of triangle with coordinates (1,2), (2,4), (4,6)", 1.0, area, 0.00001);
        
	}
	
	@Test
	public void test_Area_not_Triangle() {
    	Line line1 = new Line(new Point(2,1), new Point(3,4));
    	Line line2 = new Line(new Point(3,4), new Point(5,4));
    	Line line3 = new Line(new Point(5,4), new Point(4,2));
    	
        Triangle triangle1 = new Triangle(line1, line2, line3);
		double area = triangle1.getArea();
		
        assertEquals("Testing area of triangle with coordinates (2,1),(3,4),(5,4) and (4,2)", 0.0, area, 0.00001); 
	}
	
	@Test
	public void test_Area_lines_equal() {
		Line line1 = new Line(new Point(3,3), new Point(6,8));
    	Line line2 = new Line(new Point(6,8), new Point(3,3));
    	Line line3 = new Line(new Point(3,3), new Point(5,3));
    	
        Triangle triangle1 = new Triangle(line1, line2, line3);
		double area = triangle1.getArea();
		
        assertEquals("Testing area of triangle with coordinates (3,3),(6,8),(5,3)", 0.0, area, 0.00001); 
	}
	
	@Test
	public void test_Area_lines_overlap() {
		Line line1 = new Line(new Point(3,1), new Point(4,2));
    	Line line2 = new Line(new Point(3,1), new Point(5,3));
    	Line line3 = new Line(new Point(5,3), new Point(5,0));
    	
        Triangle triangle1 = new Triangle(line1, line2, line3);
		double area = triangle1.getArea();
		
        assertEquals("Testing area of triangle with coordinates (3,1),(4,2),(5,3) and (5,0)", 0.0, area, 0.00001); 
	}
	
	@Test
	public void test_PrivacyLeakConstructor_FirstLine() {    
    	Line line1 = new Line(new Point(1,0), new Point(5,5));
    	Line line2 = new Line(new Point(5,5), new Point(3,6));
    	Line line3 = new Line(new Point(3,6), new Point(1,0));
        Triangle triangle1 = new Triangle(line1, line2, line3);
        
        line1.setStart(new Point(-4,5));
        
        boolean unchanged = triangle1.getLine1().equals(new Line(new Point(1,0), new Point(5,5)));
		// Test if line1 of triangle has changed with the line1 that was passed in to make it
        
        assertTrue("Was able to change one of the points in triangle1 by changing one of the lines passed as a parameter", unchanged);
	}
	
	@Test
	public void test_PrivacyLeakConstructor_FirstPoint() { 
		Point  p1 = new Point(2,20);
        Line line1 = new Line(p1, new Point(4,6));
        Triangle triangle3 = new Triangle((line1),(new Line(new Point(0,0), new Point(0,0))), (new Line(new Point(0,0), new Point(0,0))));
		
		p1.moveDown(10);
		
		double circumference = triangle3.getCircumference();
		
		assertEquals("PrivacyTest1: Point (2,20) passed in as argument to constructor.  Instance changed afterwards to (2,30) but this should not effect Triangle object.  Triangle circumference from point (2,20) to (4,6) should be 14.142135", 14.142135, circumference, 0.00001);
	}

	@Test
	public void test_Getter1() {
        Triangle triangle4 = new Triangle((new Line(new Point(0,0), new Point(0,10))),(new Line(new Point(0,10), new Point(10,10))), (new Line(new Point(0,0), new Point(10,10))));
		double length = triangle4.getLine1().length();
		
        assertEquals("Testing getter1 line length: ", 10.0, length, 0.00001); 
        
    }
	
	@Test
	public void test_Getter2() {
        Triangle triangle4 = new Triangle((new Line(new Point(0,0), new Point(0,10))),(new Line(new Point(0,10), new Point(10,10))), (new Line(new Point(0,0), new Point(10,10))));
		double length = triangle4.getLine2().length();
		
        assertEquals("Testing getter2 line length: ", 10.0, length, 0.00001); 
        
	}
	@Test
	public void test_Getter3() {
        Triangle triangle4 = new Triangle((new Line(new Point(0,0), new Point(0,10))),(new Line(new Point(0,10), new Point(10,10))), (new Line(new Point(0,0), new Point(10,10))));
		double length = triangle4.getLine3().length();
		
        assertEquals("Testing getter3 line length: ", 10.0, length, 0.00001); 
        
    }
	


}

