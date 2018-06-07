//Team Unlucky 13 

/**
* This class contains the balance of a bank account and methods to change said balance.
*/
public class BankAccount { 

    private double balance;

    /**
    * Transfers money from this bank account to a second bank account.
    * Ensures that the account cannot be overdrawn.
    *
    * @param  balanceToTransfer  the amount of money to be given to the second bank account
    * @param  accountName        the name of the bank account that will receive the transfer
    * @return the updated balance of this account
    */
    public double transfer(double balanceToTransfer, BankAccount accountName) {
        if (balanceToTransfer <= balance) {
            accountName.balance += balanceToTransfer;
            balance -= balanceToTransfer;
        }

        return balance;
    }
    public BankAccount(){

    }

    public BankAccount(BankAccount accountToCopy){
        accountToCopy.balance=balance;
    }

    public BankAccount(double balance){

    }
    /**
    * Retrieves the current balance of the account.
    *
    * @return the current balance
    */
    public double getBalance() {
        return balance;
    }
    
    /**
    * Updates the balance of this account after depositing money.
    * Ensures that one cannot deposit a negative amount of money.
    *
    * @param  amountDeposited  the amount of money to be added to the account
    * @return the updated account balance
    */
    public double deposit(double amountDeposited) {
        if (amountDeposited > 0) {
            balance += amountDeposited;
        }
    
        return balance; 
    }

    /**
    * Updates the balance of this account after withdrawing money.
    * Ensures account is not overdrawn.
    *
    * @param  amountWithdrawn  the amount of money to be removed from to the account
    * @return the updated account balance
    */
    public double withdraw(double amountWithdrawn) {
        if (balance - amountWithdrawn >= 0) {
            balance -= amountWithdrawn;
        }

        return balance;
    }

}