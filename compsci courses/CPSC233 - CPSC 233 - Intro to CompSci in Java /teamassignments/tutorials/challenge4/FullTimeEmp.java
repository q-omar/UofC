public class FullTimeEmp extends Employee{
    private double salary;

    public FullTimeEmp(String aName, String anID, double aSalary){
        super(aName,anID);
        salary = aSalary;
    }

    public String getStatus(){
        String status = "Full time employee";
        return status;
    }

    public double getMonthlyPay(){
        double monthly = salary/12;
        return monthly;
    }

    public void setSalary(int amount){
        salary = amount;
    }
    
}