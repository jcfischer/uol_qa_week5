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

  end
end
