require "./account_operations"
#require "./menu_helper"


#include MenuHelper

class BankAccount
  include AccountOperations

  @@number_of_bank_accounts = 0
  @@all = []

  attr_reader :name, :pin, :transaction_fee_percentage
  attr_accessor :bank_money

  TRANSACTION_FEE_PERCENTAGE = 0.02

  def initialize(**args)
    @@number_of_bank_accounts += 1
    @name = args[:name]
    @pin = args[:pin]
    @bank_money = args[:bank_money]

    @@all << self
  end

  def authenticate_pin(entered_pin)
    return entered_pin.to_s == pin.to_s
  end
  
  def can_user_withdraw(money_to_withdraw)
    if (bank_money >= money_to_withdraw || money_to_withdraw >= 0)
      return true
    else
      return false
    end
  end

  def can_user_deposit(money_to_deposit)
    if (money_to_deposit >= 0)
      return true
    else
      return false
    end
  end

  def withdraw_money(money_to_withdraw)
    if (can_user_withdraw(money_to_withdraw) == true)
      @bank_money -= money_to_withdraw.to_i
      charge_transaction_fee(money_to_withdraw)
    else
      puts "Insufficient funds."
    end
  end

  def deposit_money(money_to_deposit)
    if (can_user_deposit(money_to_deposit) == true)
      @bank_money += money_to_deposit
    end
  end

  def charge_transaction_fee(money_to_withdraw)
    if (can_user_withdraw(money_to_withdraw) == true)
      @bank_money -= money_to_withdraw * TRANSACTION_FEE_PERCENTAGE
    end
  end

  def display_bank_money
    puts "\nYou now have #{bank_money}$ in your bank account.\n\n"
  end

  #class << self
  #end
  
  def self.capture_bank_info
    name = enter_user_name
    pin = enter_pin
    bank_money = rand(1000000)

    display_account_info_when_new_account_created(name, pin, bank_money)
    
    {
      name: name,
      pin: pin,
      bank_money: bank_money
    }
  end

  def self.total_number_of_accounts
    return @@number_of_bank_accounts
  end

  def self.all
    @@all
  end

  def self.find_by_name(user_entered)

    BankAccount.all.each_with_index do |account|
      if user_entered == account.name
        return account
        #entered_pin = enter_pin
        #authenticate_pin(entered_pin)
      end
    end

    return nil
    
  end

  def self.transfer_money_between_users(user1, user2, amount_of_money_to_transfer)
    if (user1.can_user_withdraw(amount_of_money_to_transfer) == true)
      user1.withdraw_money(amount_of_money_to_transfer)
      user2.deposit_money(amount_of_money_to_transfer)
      true
    else
      false
    end
  end
end

