require 'rspec'

require './account'

describe AtmPackage::Account do

  context "#initialize" do
    it "should assign the initial balance" do
      account = AtmPackage::Account.new 1000
      account.balance.should == 1000
    end

    it "should assign a 0 balance" do
      account = AtmPackage::Account.new 0
      account.balance.should == 0
    end

    it "should assign balance to 0 if inital amount is negative" do
      account = AtmPackage::Account.new -10
      account.balance.should == 0
    end
  end

  context "#balance=" do
    let(:account) { AtmPackage::Account.new 0 }

    it "should set the balance to a new value" do
      account.balance = 50
      account.balance.should == 50
    end

    it "should not set the balance if value is negative" do
      account.balance = -10
      account.balance.should == 0
    end

    it "should not set the value if balance > 10_000_000_000_000" do
      account.balance = 20_000_000_000_000
      account.balance.should == 0
    end
  end

  context "#deposit" do
    let(:account) { AtmPackage::Account.new 100 }

    it "should correctly deposit money into the account" do
      account.deposit 42
      account.balance.should == 142
    end

    it "should not deposit a negative amount" do
      account.deposit -42
      account.balance.should == 100
    end

    it "should not deposit more than the account limit" do
      account.deposit 400_000_000
      account.balance.should == 100
    end
  end

  context "#withdraw" do
    let(:account) { AtmPackage::Account.new 1000 }

    it "should correctly withdraw a sum smaller than the current balance" do
      account.withdraw 50
      account.balance.should == 950
    end

    it "should not allow to withdraw more than the balance" do
      account.withdraw 1100
      account.balance.should == 1000
    end

    it "should not allow to withdraw more then the withdrawal limit" do
      account.withdraw 600
      account.balance.should == 1000
    end
  end

  context "#transfer_funds" do
    context "balance available" do
      let(:account_1) { AtmPackage::Account.new 100 }
      let(:account_2) { AtmPackage::Account.new 100 }

      before(:each) do
        account_1.transfer_funds account_2, 20
      end

      it "should debit the amount from account_1" do
        account_1.balance.should == 80
      end
      it "should credit the amount to account_2" do
        account_2.balance.should == 120
      end
    end

    context "negative transfer amount" do
      let(:account_1) { AtmPackage::Account.new 100 }
      let(:account_2) { AtmPackage::Account.new 100 }

      before(:each) do
        account_1.transfer_funds account_2, -20
      end

      it "should not debit the amount from account_1" do
        account_1.balance.should == 100
      end
      it "should not credit the amount to account_2" do
        account_2.balance.should == 100
      end
    end

    context "overdrawn transfer amount" do
      let(:account_1) { AtmPackage::Account.new 100 }
      let(:account_2) { AtmPackage::Account.new 100 }

      before(:each) do
        account_1.transfer_funds account_2, 120
      end

      it "should not debit the amount from account_1" do
        account_1.balance.should == 100
      end
      it "should not credit the amount to account_2" do
        account_2.balance.should == 100
      end
    end
  end

  context "#==" do
    context "identical balance" do
      let(:account_1) { AtmPackage::Account.new 100 }
      let(:account_2) { AtmPackage::Account.new 100 }

      it "should treat the accounts as equal" do
        account_1.should == account_2
      end
    end

    context "different balance" do
      let(:account_1) { AtmPackage::Account.new 100 }
      let(:account_2) { AtmPackage::Account.new 102 }

      it "should not treat the accounts as equal" do
        account_1.should_not == account_2
      end
    end
  end

  context "Expose withdraw bug" do
    let(:account_1) { AtmPackage::Account.new 10_000_000_000_000 }
    let(:account_2) { AtmPackage::Account.new 10_000_000_000_000 }

    before(:each) do
      account_1.transfer_funds account_2, 9_000_000_000_000.0
    end
    it "should transfer 9_000_000_000_000" do
      account_1.balance.should == 1_000_000_000_000.0
    end
    it "should deduct from account 2" do
      account_2.balance.should == 19_000_000_000_000.0
    end
  end

end
