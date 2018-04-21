import static org.junit.Assert.*;

import org.junit.Test;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class FullTimeEmpTest {
	
	// checks if salary is the only private thing in the class.
	private boolean instanceVariablesArePrivate(){
		boolean salaryIsPrivate = true;
		
		
		try {
			BufferedReader in = new BufferedReader(new FileReader("FullTimeEmp.java"));
			String line = in.readLine();
			while (line != null) {
				if (line.contains("private")) {
					line = line.trim();
					if (line.length() >= 21 ) {
						line = line.substring(0,21);
						if (!line.equals("private double salary")){
							salaryIsPrivate = false;
						}
					} 
				}
				line = in.readLine();
			}
			in.close();
		} catch (FileNotFoundException e) {
			salaryIsPrivate = false;
		} catch (IOException e) {
			salaryIsPrivate =  false;
		}
		return salaryIsPrivate;
	}
	
	private boolean hasMethod(String signature) {
		boolean contains = false;
		
		try {
			BufferedReader in = new BufferedReader(new FileReader("FullTimeEmp.java"));
			String line = in.readLine();
			while (line != null) {
				if (line.contains(signature)) {
					contains = true;
				}
				line = in.readLine();
			}
			in.close();
		} catch (FileNotFoundException e) {
			contains = false;
		} catch (IOException e) {
			contains =  false;
		}
		return contains;
	
	}	
	
	private boolean toStrInvokesParentToStr(){
		boolean callsGetter = false;
		boolean callsParent = false;
		
		
		try {
			BufferedReader in = new BufferedReader(new FileReader("FullTimeEmp.java"));
			String line = in.readLine();
			while (line != null) {
				if (line.contains("toStr")) {
					// This should be start of toStr method
					while (!line.contains("}")) {
						line = in.readLine();
						if (line.contains("getName") || line.contains("getIDNum")){
							callsGetter = true;
						}
						if (line.contains("super.toStr")) {
							callsParent = true;
						}
					}
				}
				line = in.readLine();
			}
			in.close();
		} catch (FileNotFoundException e) {
			callsParent = false;
		} catch (IOException e) {
			callsParent =  false;
		}
		return callsParent && !callsGetter;
	}
	
	

	@Test
	public void test_Constructor(){
		assertTrue("Instance variables should be private.",instanceVariablesArePrivate());
		assertFalse("Should not override toStr.", hasMethod("String toStr"));
		assertFalse("Should not override calculateMonthyPay.", hasMethod("double calculateMonthlyPay"));
		
		FullTimeEmp f1 = new FullTimeEmp("Adam","1",1000.0);
		
		assertEquals("Created Full time employee Adam, 1, 1000.0. Name: ", "Adam", f1.getName());
		assertEquals("Created Full time employee Adam, 1, 1000.0. IDNum: ", "1", f1.getIDNum());
		assertEquals("Created Full time employee Adam, 1, 1000.0. Monthly salary: ", 83.33333, f1.getMonthlyPay(), 0.0001);

	}


	@Test
	public void test_setSalary(){
		assertTrue("Instance variables should be private.",instanceVariablesArePrivate());
		assertFalse("Should not override toStr.", hasMethod("String toStr"));
		assertFalse("Should not override calculateMonthyPay.", hasMethod("double calculateMonthlyPay"));
		
		FullTimeEmp f1 = new FullTimeEmp("Verity","3957",1.0);
		f1.setSalary(12);
		
		assertEquals("Created Full time employee Verity, 3957,1.0 and set salary to 12. Name: ", "Verity", f1.getName());
		assertEquals("Created Full time employee Verity, 3957,1.0 and set salary to 12. IDNum: ", "3957", f1.getIDNum());
		assertEquals("Created Full time employee Verity, 3957,1.0 and set salary to 12. Monthly Salary: ", 1.0, f1.getMonthlyPay(), 0.0001);

	}

	@Test
	public void test_toStr(){
		assertTrue("Instance variables should be private.",instanceVariablesArePrivate());
		assertFalse("Should not override toStr.", hasMethod("String toStr"));
		assertFalse("Should not override calculateMonthyPay.", hasMethod("double calculateMonthlyPay"));

		FullTimeEmp f1 = new FullTimeEmp("Adam","1", 1000.0);
		
		assertEquals("Created Full time employee Adam,1,1000.0.", "IDNum: 1 Name: Adam MonthlyPay: 75.0 Status: Full time employee", f1.toStr());
		

	}

	@Test
	public void test_toStr2(){
		assertTrue("Instance variables should be private.",instanceVariablesArePrivate());
		assertFalse("Should not override toStr.", hasMethod("String toStr"));
		assertFalse("Should not override calculateMonthyPay.", hasMethod("double calculateMonthlyPay"));
		
		FullTimeEmp f1 = new FullTimeEmp("Grace Hopper","5694", 2340.0);
		
		assertEquals("Created Full time employee Grace Hopper,5694,23400.0.", "IDNum: 5694 Name: Grace Hopper MonthlyPay: 175.5 Status: Full time employee", f1.toStr());
		

	}
	
	@Test
	public void test_getStatus(){
		assertTrue("Instance variables should be private.",instanceVariablesArePrivate());
		assertFalse("Should not override toStr.", hasMethod("String toStr"));
		assertFalse("Should not override calculateMonthyPay.", hasMethod("double calculateMonthlyPay"));
			
		FullTimeEmp f1 = new FullTimeEmp("Adam","1",10000.0);
		
		assertEquals("Testing the getStatus method:", "Full time employee", f1.getStatus());
		

	}

}
