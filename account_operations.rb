require './bank_account'
#require './menu_helper'
require 'pry'

#include MenuHelper

module AccountOperations

  def enter_user_name
    puts "\nPlease enter user name: \n\n"
    return gets.chomp
  end

  def enter_pin
    puts "\nPlease enter 4-digit pin: \n\n"
    return pin_entered = gets.chomp
  end

  def find_and_delete_account

    account_to_delete = BankAccount.find_by_name(enter_user_name)
    
    if (account_to_delete != nil)
    
      user_to_delete = account_to_delete.name
      
      is_pin_entered_valid = account_to_delete.authenticate_pin(enter_pin)

      if(is_pin_entered_valid == true)
        puts "\nDo you wish to delete #{user_to_delete}?\n\n"

        wish_to_delete = gets.chomp.upcase

        if wish_to_delete == "YES"
          BankAccount.all.each_with_index do |acc,i|
            if user_to_delete == acc.name
              BankAccount.all.delete_at(i)
              puts "\nUser #{user_to_delete} deleted. "
            end
          end
        else
          puts "Chou Bek?"
        end
      end
    else 
      puts "Invalid User. Please Try Again"
      find_and_delete_account
    end
  end

  def make_transaction

    account_entered = BankAccount.find_by_name(enter_user_name)

    puts "\nHello #{account_entered.name}! You have #{account_entered.bank_money}$ in your account. \n\nPress R if you wish to retrieve money from your account. \nPress D if you wish to deplosit money in your account. \nPress T if you wish to transfer money to another account. \n"

    transaction_option = gets.chomp.upcase

    case transaction_option
    when "R"
      warn_about_transaction_fee
      account_entered.withdraw_money(enter_amount_of_money_to_withdraw)
      account_entered.display_bank_money
    when "D"
      account_entered.deposit_money(enter_amount_of_money_to_deposit)
      account_entered.display_bank_money
    when "T"
      warn_about_transaction_fee
      BankAccount.transfer_money_between_users(account_entered, enter_user_to_transfer_money_to, enter_amount_of_money_to_transfer)
      account_entered.display_bank_money
    else
      puts "\nChou Bek?"
    end
  end

  def enter_user_to_transfer_money_to
    puts "\nPlease enter user to transfer money to"
    user_to_transfer_money_to = BankAccount.find_by_name(enter_user_name)
  end

  def enter_amount_of_money_to_transfer
    puts "\nPlease enter the amount of money you wish to transfer: \n\n"
    money_to_transfer = gets.chomp.to_i
  end

  def enter_amount_of_money_to_withdraw
    puts "\nPlease enter the amount of money you wish to withdraw: \n\n"

    money_to_withdraw = gets.chomp.to_i    
  end

  def enter_amount_of_money_to_deposit
    puts "\nPlease enter the amount of money you with to deposit: \n\n"

    money_to_deposit = gets.chomp.to_i
  end

  # Move to bank_account?

  def warn_about_transaction_fee
    puts "\nThere will be a transaction fee of #{BankAccount::TRANSACTION_FEE_PERCENTAGE}%.\n\n"
  end

  def display_account_info_when_new_account_created(name, pin, bank_money)
    puts "\nMabrouk #{name}! You now have a banking account with pin ##{pin}. You just became 50% cooler than you were 5 minutes ago!"

    puts "\nYou have #{bank_money} $ in your bank account boss!"
  end
end