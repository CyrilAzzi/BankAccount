require './bank_account'
require './menu_helper'
require './account_operations'

require 'pry'

include MenuHelper
include AccountOperations

# Permettre aux users d'avoir plusieurs types de comptes et plusieurs comptes en même temps
# Ex: Leon peut avoir un Checking account, un saving account, un investment account, etc. 
# Transférer l'argent d'un compte à l'account
# Elle devra choisir de quel account à quel account transférer son argent

# Le menu doit donner le choix entre tous les types de comptes disponibles et le user répond 1 2 ou 3

#Introduction message
intro_message

#Loading the options
answer = "yes"

BankAccount.new(name: "Leon", pin: 1234, bank_money: rand(1000000))
BankAccount.new(name: "Cyril", pin: 9876, bank_money: rand(1000000))

while answer == "yes"
  option = choose_menu_option  
  handle_menu_choice(option)
  
  puts "\nDo you wish to continue?\n\n"

  answer = gets.chomp.downcase

  if answer == "no"
    puts "\nGoodbye boss!"
  end
end

