module AtmPackage

  class Account
    attr_reader :balance # creates getter automatically

    def initialize balance
      if balance < 0
        balance = 0
        puts "Error, balance cannot be negative. Defaulting to 0"
        # error 1: @balance not assigned
      end
      self.balance = balance
    end

    def balance= balance
      if balance < 0
        puts "Error - balance must be positive!"
      else
        if balance > 10_000_000_000_000.0
          puts "Error - balance must be < 10,000,000,000,000"
        else
          @balance = balance;
        end
      end
    end

    def deposit deposit_amount
      if deposit_amount > 300_000_000.0
        puts "Error - exceeded deposit limit of 300,000,000! Balance is still #{@balance}";
      else
        if deposit_amount <= 0
          puts "Error - deposit amount must be positive! Balance is still #{@balance}"
        else
          @balance = @balance + deposit_amount
          puts "Deposit successful. Balance is now #{balance}"
        end
      end
    end

    def withdraw withdraw_amount
      if balance < withdraw_amount
        puts "Error - overdrawn! Balance is still #{@balance}"
      else
        if withdraw_amount <= 0
          puts "Error - withdrawal amount must be positive! Balance is still #{balance}"
        else
          if withdraw_amount > 500.00
            puts "Error - withdrawal limit is 500.00"
          else
            @balance = @balance - withdraw_amount
            puts "Withdrawal successful. Balance is now #{@balance}"
          end
        end
      end
    end

    def transfer_funds receiving_account, transfer_amount
      if balance < transfer_amount
        puts "Error, transfer amount exceeds sending account balance."
      else
        if transfer_amount <=0
          puts "Error, transfer amount must be positive."
        else
          # design nastiness - this method actually touces way to far into the
          # other object. It should be the responsibility of the receiving object
          # to get the money (for example by using the deposit method) I would
          # probably disallow the balance= setter at all
          receiving_account.balance = receiving_account.balance + transfer_amount
          @balance = @balance - transfer_amount
        end
      end
    end

    def == an_account
      if an_account.respond_to?(:balance)
        return an_account.balance == self.balance
      end
      return false
    end

    def negative?
      @balance < 0
    end
  end
end
