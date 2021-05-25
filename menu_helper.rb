require './bank_account'
require './account_operations'
require 'pry'

include AccountOperations

module MenuHelper

  # Introduction message
  def intro_message

    puts "Hello my friend! Welcome to Chou Bek Banking Services. We are the solution to all your financial problems. Not many people in this world have the chance to know us, but those who do receive the power to live an interesting life \n\nEnough said now. Let us begin!"

    puts "\nPress enter to continue"

    enter = gets.chomp
  end

  # Navigation choices
  def choose_menu_option

    puts "\nPlease choose one of the following options: \nA-Create new account \nB-View All Accounts \nC-Delete Account \nD-Make a Transaction \nE-Exit Application\n\n"

    option = gets.chomp.upcase

    return option
  end

  def handle_menu_choice(chosen_option)
    
    case chosen_option
    when "A"
      create_new_bank_account
    when "B"
      view_all_accounts
    when "C"
      delete_account
    when "D"
      make_transaction
    when "E"
      exit_application
    else
      puts "Chou Bek?"
    end
  end

  def create_new_bank_account
    bank_info = BankAccount.capture_bank_info
    BankAccount.new(bank_info)
  end

  def view_all_accounts
    print "\n"
    puts "Here is a list of all the registered users in the bank:\n\n"
    
    BankAccount.all.each_with_index do |acc, i|
      puts "User ##{i+1}: #{acc.name}"
    end
  end

  def delete_account
    find_and_delete_account
  end

  def exit_application
    puts "Goodbye and thank you for using Chou Bek Banking services!"
  end
end