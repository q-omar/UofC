import static org.junit.Assert.*;

import org.junit.Test;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class PartTimeEmpTest {
	
	private boolean instanceVariablesArePrivate(){
		boolean hourlyRateIsPrivate = false;
		boolean hoursPerWeekIsPrivate = false;
		
		try {
			BufferedReader in = new BufferedReader(new FileReader("PartTimeEmp.java"));
			String line = in.readLine();
			while (line != null) {
				if (line.contains("private")) {
					line = line.trim();
					if (line.length() >= 25 ) {
						line = line.substring(0,25);
						if (line.equals("private double hourlyRate")){
							hourlyRateIsPrivate = true;
						}
					} 
					if (line.length() >= 17 ){
						line = line.substring(0,17);
						if (line.equals("private int hours")){
							hoursPerWeekIsPrivate = true;
						}
					}
				}
				line = in.readLine();
			}
			in.close();
		} catch (FileNotFoundException e) {
			hourlyRateIsPrivate = false;
		} catch (IOException e) {
			hourlyRateIsPrivate =  false;
		}
		return hourlyRateIsPrivate && hoursPerWeekIsPrivate;
	}	
	
	private boolean calculateMonthlyPayInvokesParentcalculate(){
		boolean callsParent = false;
		
		
		try {
			BufferedReader in = new BufferedReader(new FileReader("PartTimeEmp.java"));
			String line = in.readLine();
			while (line != null) {
				if (line.contains("calculateMonthlyPay")) {
					// This should be start of method
					while (!line.contains("}")) {
						line = in.readLine();
						if (line.contains("super.calculateMonthlyPay")) {
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
		return callsParent;
	}
	
	

	@Test
	public void test_getMonthlyPay_zeroHours(){
		assertTrue("Instance variables should be private.",instanceVariablesArePrivate());
		assertTrue("Should override calculateMonthlyPay, which invokes parent calculateMontlyPay", calculateMonthlyPayInvokesParentcalculate());
		
		PartTimeEmp p1 = new PartTimeEmp("Adam","1",10.0);
		
		assertEquals("Created Part time employee with 0 hours,10 dollers rate, testing if getMonthlyPay is correct:", 0.0, p1.getMonthlyPay(),0.0000001);
		assertEquals("Hours and rate should be unchanged after calling getMonthlyPay, calling GetMontlyPay again.", 0.0, p1.getMonthlyPay(),0.0000001);
		

	}

	@Test
	public void test_getMonthlyPay_zeroHourlyPay(){
		assertTrue("Instance variables should be private.",instanceVariablesArePrivate());
		assertTrue("Should override calculateMonthlyPay, which invokes parent calculateMontlyPay", calculateMonthlyPayInvokesParentcalculate());
		
		PartTimeEmp p1 = new PartTimeEmp("Adam","1",0.0);
		p1.addToHours(10);
		assertEquals("Created Part time employee with 10 hours,0 dollers rate, testing if getMonthlyPay is correct:", 0.0, p1.getMonthlyPay(),0.0000001);
		assertEquals("Hours and rate should be unchanged after calling getMonthlyPay, calling GetMontlyPay again.", 0.0, p1.getMonthlyPay(),0.0000001);

	}

	@Test
	public void test_getMonthlyPay_hourly12Hours10(){
		assertTrue("Instance variables should be private.",instanceVariablesArePrivate());
		assertTrue("Should override calculateMonthlyPay, which invokes parent calculateMonthlyPay", calculateMonthlyPayInvokesParentcalculate());
		
		PartTimeEmp p1 = new PartTimeEmp("Adam","1",12.0);
		p1.addToHours(10);
		assertEquals("Created Part time employee with 10 hours,12.0 dollers rate, testing if getMonthlyPay is correct:", 120.0, p1.getMonthlyPay(),0.0000001);
		assertEquals("Hours and rate should be unchanged after calling getMonthlyPay, calling GetMontlyPay again.", 120.0, p1.getMonthlyPay(),0.0000001);
	}
	
	@Test
	public void test_calculateMonthlyPay_10hours(){
		assertTrue("Instance variables should be private.",instanceVariablesArePrivate());
		assertTrue("Should override calculateMonthlyPay, which invokes parent calculateMontlyPay", calculateMonthlyPayInvokesParentcalculate());
		
		PartTimeEmp p1 = new PartTimeEmp("Adam","1",12.0);
		p1.addToHours(10);
		assertEquals("Created Part time employee with 10 hours,12.0 dollers rate, testing if calculateMonthlyPay is correct:", 108.0, p1.calculateMonthlyPay(),0.0000001);
		assertEquals("After calculateMontlyPay, hours should be reset to zero.", 0.0, p1.getMonthlyPay(), 0.0000001);
		
	}

	@Test
	public void test_toStr(){
		assertTrue("Instance variables should be private.",instanceVariablesArePrivate());
		
		
		PartTimeEmp p1 = new PartTimeEmp("Grace","54",5.0);
		p1.addToHours(25);
		
		assertEquals("Created Grace, 54, 25 hours,5 dollers rate", "IDNum: 54 Name: Grace MonthlyPay: 112.5 Status: Part time employee", p1.toStr());
		

	}

	@Test
	public void test_get_status(){
		assertTrue("Instance variables should be private.",instanceVariablesArePrivate());
		
		PartTimeEmp p1 = new PartTimeEmp("Adam","1",10.0);
		
		assertEquals("Testing the getStatus method:", "Part time employee", p1.getStatus());
		

	}

}
