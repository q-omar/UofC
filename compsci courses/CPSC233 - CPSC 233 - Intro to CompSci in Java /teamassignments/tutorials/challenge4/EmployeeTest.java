import static org.junit.Assert.*;

import org.junit.Test;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class EmployeeTest {
	public class Emp extends Employee{
		double monthly;

		public Emp(String name, String ID){
			super(name,ID);
		}
		public String getStatus(){
			return "F";
		}
		
		public double getMonthlyPay(){
			return monthly;
		}
	}

	public static final String CLASSNAME = "Employee";
	public static final String FILENAME = CLASSNAME + ".java";
	
	private boolean hasRequiredAbstractMethods(String[] abstractMethods) {
		boolean[] methodsAbstract = new boolean[abstractMethods.length];
		for (int index = 0; index < abstractMethods.length; index++){
			methodsAbstract[index] = false;
		}
		boolean classIsAbstract = false;
		
		try {
			BufferedReader in = new BufferedReader(new FileReader(FILENAME));
			String line = in.readLine();
			while (line != null) {
				if (line.contains("public abstract class " + CLASSNAME)){
					classIsAbstract = true;
				} else {
					for (int index = 0; index < abstractMethods.length; index++) {
						String stmt = "public abstract " + abstractMethods[index];
						if (line.contains(stmt)) {
							methodsAbstract[index] = true;
						}
					}
				}					
				line = in.readLine();
			}
			in.close();
		} catch (FileNotFoundException e) {
			classIsAbstract = false;
		} catch (IOException e) {
			classIsAbstract = false;
		}
		
		boolean allAbstract = classIsAbstract;
		for (boolean b : methodsAbstract) {
			allAbstract = allAbstract && b;
		}
		return allAbstract;
	
	}
	
	private boolean hasRequiredProtectedMethods() {
		boolean toStrIsProtected = false;
		boolean setIDIsProtected = false;
		boolean getNameIsProtected = false;
		boolean getIDIsProtected = false;
		
		try {
			BufferedReader in = new BufferedReader(new FileReader("Employee.java"));
			String line = in.readLine();
			while (line != null) {
				if (line.contains("protected void setIDNum(") || line.contains ("protected void setIDNum (")) {
					setIDIsProtected = true;
				} else if (line.contains("protected String getName()") || line.contains("protected String getName ()")) {
					getNameIsProtected = true;
				} else if (line.contains("protected String toStr()") || line.contains("protected String toStr ()") ) {
					toStrIsProtected = true;
				} else if (line.contains("protected String getIDNum()") || line.contains("protected String getIDNum ()") ) {
					getIDIsProtected = true;
				}
				line = in.readLine();
			}
			in.close();
		} catch (FileNotFoundException e) {
			setIDIsProtected = false;
		} catch (IOException e) {
			setIDIsProtected =  false;
		}
		return setIDIsProtected && toStrIsProtected && getNameIsProtected && getIDIsProtected;
	
	}
	private boolean hasRequiredPublicMethods() {
		boolean constructorIsPublic = false;
		try {
			BufferedReader in = new BufferedReader(new FileReader("Employee.java"));
			String line = in.readLine();
			while (line != null) {
				if (line.contains("public Employee(") || line.contains("public Employee (")) {
					constructorIsPublic = true;
				} 
				line = in.readLine();
			}
			in.close();
		} catch (FileNotFoundException e) {
			constructorIsPublic = false;
		} catch (IOException e) {
			constructorIsPublic =  false;
		}
		return constructorIsPublic;
	
	}
	private boolean instanceVariablesArePrivate(){
		boolean nameIsPrivate = false;
		boolean IDIsPrivate = false;
		
		try {
			BufferedReader in = new BufferedReader(new FileReader("Employee.java"));
			String line = in.readLine();
			while (line != null) {
				if (line.contains("private")) {
					line = line.trim();
					if (line.length() >= 20 ){
						line = line.substring(0,20);
						if (line.equals("private String IDNum")){
							IDIsPrivate = true;
						}
					}
					if (line.length() >= 19 ) {
						line = line.substring(0,19);
						if (line.equals("private String name")){
							nameIsPrivate = true;
						}
					} 
				}
				line = in.readLine();
			}
			in.close();
		} catch (FileNotFoundException e) {
			nameIsPrivate = false;
		} catch (IOException e) {
			nameIsPrivate =  false;
		}
		return nameIsPrivate && IDIsPrivate;
	}	
	
	private boolean noDefaultConstructor(){
		boolean noDefault = true;
		try {
			BufferedReader in = new BufferedReader(new FileReader("Employee.java"));
			String line = in.readLine();
			while (line != null) {
				if (line.contains("public Employee()") || line.contains ("public Employee ()") || line.contains ("public Employee ( )")) {
					noDefault = false;
				}
				line = in.readLine();
			}
			in.close();
		} catch (FileNotFoundException e) {
			noDefault = false;
		} catch (IOException e) {
			noDefault =  false;
		}
		return noDefault;
	
	}

	


	@Test
	public void test_getIDNum(){
		assertTrue("Instance variables should be private with correct name and type.", instanceVariablesArePrivate());
		assertTrue("Employee should not have the default constructor.", noDefaultConstructor());
		String[] methods = {"double getMonthlyPay()", "String getStatus()"};
		assertTrue("The Employee class, getStatus and getMonthlyPay methods should be abstract with correct signature.", hasRequiredAbstractMethods(methods));
		assertTrue("constructor should be public with correct signature.", hasRequiredPublicMethods());
		
		
		Emp e1 = new Emp("Adam","1");
		
		assertEquals("Created Adam, 1.", "1", e1.getIDNum());
	
		
	}
	
	@Test
	public void test_getName(){
		assertTrue("Instance variables should be private with correct name and type.", instanceVariablesArePrivate());
		assertTrue("Employee should not have the default constructor.", noDefaultConstructor());
		String[] methods = {"double getMonthlyPay()", "String getStatus()"};
		assertTrue("The Employee class, getStatus and getMonthlyPay methods should be abstract with correct signature.", hasRequiredAbstractMethods(methods));
		assertTrue("constructor should be public with correct signature.", hasRequiredPublicMethods());
		
		
		Emp e1 = new Emp("Eve","10");
		
		assertEquals("Created Eve, 10", "Eve", e1.getName());
	
		
	}
	
	@Test
	public void test_setIDNum(){
		assertTrue("Instance variables should be private with correct name and type.", instanceVariablesArePrivate());
		assertTrue("Employee should not have the default constructor.", noDefaultConstructor());
		String[] methods = {"double getMonthlyPay()", "String getStatus()"};
		assertTrue("The Employee class, getStatus and getMonthlyPay methods should be abstract with correct signature.", hasRequiredAbstractMethods(methods));
		assertTrue("constructor should be public with correct signature.", hasRequiredPublicMethods());
		
		
		Emp e1 = new Emp("Bob","2");
		
		assertEquals("Created Bob, s then used setter for IDNum to set to 11", "2", e1.getIDNum());
	
		
	}
	
	@Test
	public void test_toStr(){
		assertTrue("Instance variables should be private with correct name and type.", instanceVariablesArePrivate());
		assertTrue("Employee should not have the default constructor.", noDefaultConstructor());
		String[] methods = {"double getMonthlyPay()", "String getStatus()"};
		assertTrue("The Employee class, getStatus and getMonthlyPay methods should be abstract with correct signature.", hasRequiredAbstractMethods(methods));
		assertTrue("constructor should be public with correct signature.", hasRequiredPublicMethods());
		
		
		Emp e1 = new Emp("Robin","432");
		
		assertEquals("Created employee to Robin and 432.  Test subclass always returns 0 for monthly pay and F for status.", "IDNum: 432 Name: Robin MonthlyPay: 0.0 Status: F", e1.toStr());
		
	}

	@Test
	public void test_toStr2(){
		assertTrue("Instance variables should be private with correct name and type.", instanceVariablesArePrivate());
		assertTrue("Employee should not have the default constructor.", noDefaultConstructor());
		String[] methods = {"double getMonthlyPay()", "String getStatus()"};
		assertTrue("The Employee class, getStatus and getMonthlyPay methods should be abstract with correct signature.", hasRequiredAbstractMethods(methods));
		assertTrue("constructor should be public with correct signature.", hasRequiredPublicMethods());
		
		
		Emp e1 = new Emp("First Last","22");
		
		assertEquals("Created employee to First Last and 22.Test subclass always returns 0 for monthly pay and F for status.", "IDNum: 22 Name: First Last MonthlyPay: 0.0 Status: F", e1.toStr());
		
	}
	
	@Test
	public void test_calculateMonthlyPay_zero(){
		assertTrue("Instance variables should be private with correct name and type.", instanceVariablesArePrivate());
		assertTrue("Employee should not have the default constructor.", noDefaultConstructor());
		String[] methods = {"double getMonthlyPay()", "String getStatus()"};
		assertTrue("The Employee class, getStatus and getMonthlyPay methods should be abstract with correct signature.", hasRequiredAbstractMethods(methods));
		assertTrue("constructor should be public with correct signature.", hasRequiredPublicMethods());
		
		
		Emp e1 = new Emp("First Last","22");
		e1.monthly = 0.0;
		
		assertEquals("No tax on monthly pay of 0.0", 0.0, e1.calculateMonthlyPay(),0.000001);
		
		
	}

	@Test
	public void test_calculateMonthlyPay_1000(){
		assertTrue("Instance variables should be private with correct name and type.", instanceVariablesArePrivate());
		assertTrue("Employee should not have the default constructor.", noDefaultConstructor());
		String[] methods = {"double getMonthlyPay()", "String getStatus()"};
		assertTrue("The Employee class, getStatus and getMonthlyPay methods should be abstract with correct signature.", hasRequiredAbstractMethods(methods));
		assertTrue("constructor should be public with correct signature.", hasRequiredPublicMethods());
		
		
		Emp e1 = new Emp("First Last","22");
		e1.monthly = 83.333333;
		
		assertEquals("Tax on monthly pay of 83.333333 is 8.33333.", 74.99999997, e1.calculateMonthlyPay(),0.000001);
		
		
	}

	
}
