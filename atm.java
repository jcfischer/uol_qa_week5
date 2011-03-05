/*
 * Account.java
 *
 * Created on September 11, 2006, 4:41 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package ATMPkg;

/**
 *
 * @author sunny
 */
public class Account {
   
    double balance; 
    
    /** Creates a new instance of Account */
    public Account(double balance) {
        if(balance < 0)
        {
            balance = 0;
            System.out.println("Error, balance cannot be negative. Defaulting to 0.");
        }
        else
            this.balance = balance;
    }
    
    public void setBalance(double balance){
        if(balance < 0)
            System.out.println("Error - balance must be positive!");
        else if(balance > 10000000000000.0)
            System.out.println("Error - balance must be < 10,000,000,000,000");
        else
            this.balance = balance;
        
    }
    
    public double getBalance(){
        return balance;
    }
    
    public void deposit(double depositAmt){
        if(depositAmt > 300000000.0)
            System.out.println("Error - exceeded deposit limit of 300,000,000! Balance is still " + balance);
        else if(depositAmt <= 0)
            System.out.println("Error - deposit amount must be positive! Balance is still " + balance);
        else
        {
            balance = balance + depositAmt;
            System.out.println("Deposit successful. Balance is now " + balance);
        }    
    }
    
    public void withdraw(double withdrawAmt){
        if(balance < withdrawAmt)
        {
            System.out.println("Error - overdrawn! Balance is still " + balance);
        }
        else if(withdrawAmt <= 0)
        {
            System.out.println("Error - withdrawal amount must be positive! Balance is still " + balance);
        }
        else if(withdrawAmt > 500.00)
        {
            System.out.println("Error - withdrawal limit is 500.00");
        }
        else
        {
            balance = balance - withdrawAmt;
            System.out.println("Withdrawal successful. Balance is now " + balance);
        }    
    }
    
    public void transferFunds(Account receivingAcct, double transferAmt)
    {
        if(balance < transferAmt)
            System.out.println("Error, transfer amount exceeds sending account balance.");
        else if(transferAmt <=0)
            System.out.println("Error, transfer amount must be positive.");
        else
        {
            receivingAcct.setBalance(receivingAcct.getBalance() + transferAmt);
            balance = balance - transferAmt;
        }
    }
    
    public boolean equals(Object anObject){
        if(anObject instanceof Account){
            Account anAccount = (Account)anObject;
            return anAccount.getBalance() == getBalance();
        }
        return false;
    }
    
    public boolean negative(){
        return (getBalance() < 0);
    }
}

