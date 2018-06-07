public class PartTimeEmp extends Employee{
    private int hours;
    private double hourlyRate;

    public PartTimeEmp(String aName, String anID, double aRate){
        super(aName, anID);
        hourlyRate = aRate;
    }

    public void addToHours(int anAmount){
        hours+=anAmount;
    }
    
    public double calculateMonthlyPay(){
        double calculatePay = super.calculateMonthlyPay();
        hours = 0;
        return calculatePay;
    
    }

    public String getStatus(){
        String status = "Part time employee";
        return status;
    }

    public double getMonthlyPay(){
        double monthlyPay = hours*hourlyRate;
        return monthlyPay;
    }
    
}