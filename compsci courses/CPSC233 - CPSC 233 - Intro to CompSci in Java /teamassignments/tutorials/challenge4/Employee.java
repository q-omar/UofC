public abstract class Employee{

    private String name;
    private String IDNum;

    public Employee(String aName, String anID){
        name = aName;
        IDNum = anID;
    }
    
    public String getIDNum(){
        return IDNum;
    }

    public String getName(){
        return name;
    }

    public abstract double getMonthlyPay();
    public abstract String getStatus();

    public double calculateMonthlyPay(){
        double monthPay = getMonthlyPay();
        double tax = getMonthlyPay()*0.10;
        double finalMonthPay = monthPay - tax;
        return finalMonthPay;
    }

    public String toStr(){
        double aDouble = calculateMonthlyPay();
        String calculatedAsString = String.valueOf(aDouble); 
        String aString = "IDNum: " + getIDNum() + " Name: " + getName() + " MonthlyPay: "+ calculatedAsString + " Status: " + getStatus();
        return aString;
    }

}