# A banking application
# A loop with a bank, where you can do multiple features with an account
# Authors: Joey Kitzhaber

#Class definitions

class Bank
    @@default_accrue_rate = 0.02
    @@default_bank_name = "Bank of Doves"

    #initializes the new Bank
    def initialize(bank_name : String, accrue_rate : Float64)
        @name = bank_name || @@default_bank_name
        @customer = [] of Customer
        @accruement_rate = accrue_rate || @@default_accrue_rate
    end

    #Changes the name of the bank from the default
    def set_name(name : String)
        @name = name
    end

    #Returns the name of the bank
    def get_name
        @name
    end

    #Changes the Bank's accrue rate
    def set_accrue_rate(rate : Float64)
        @accruement_rate = rate
    end

    #Gets the present accrue rate
    def get_accrue_rate
        @accruement_rate
    end

    #Adds a cusomter
    def add_cust(customer_add : Customer)
        @customer.insert(-1, customer_add)
    end

    #Deletes customers with a given name off the list
    def delete_cust(name : String)
        size = @customer.size
        pos = 0
        delcount = 0
        until pos >= size
            if name = @customer[pos].get_name
                @customer.delete_at(pos)
                delcount += 1
            end
            pos += 1
        end
        return delcount
    end

    #Returns the customer list
    def customer_list
        @customer
    end

    #tostring method
    def to_s
        return "Bank Name: "+@name
    end

end

#A module with functions for both Savings and Checking Accounts
module Account
    #Returns the balance of an account

    def get_balance
        @balance
    end

    #Sets the balance of the account
    def set_balance(bal : Float64)
        @balance = bal
    end

    #Deposits into the account
    def deposit(dep : Float64)
        @balance = @balance + dep
    end

    #Withdraws from the account
    def withdraw(wit : Float64)
        @balance = @balance + wit
    end
end

#Class definition of SavingsAccount
class SavingsAccount
    include Account

    #Initializes the savings account with a balance
    def initialize(bal : Float64)
        @balance = bal
    end

    def accrue(rate : Float64)
        rounded = @balance + (@balance * rate)
        @balance = rounded.round(2)
    end
end

#Class definition of CheckingAccount
class CheckingAccount
    include Account

    def initialize(bal : Float64)
        @balance = bal
    end

    def accrue(rate : Float64)
    end
end

class Customer
    @@default_name = "Nameless"
    @@default_checking = CheckingAccount.new(0)
    @@default_savings = SavingsAccount.new(0)
    #Initialize customer
    def initialize
        @name = @@default_name
        @CheckingAccount = @@default_checking
        @SavingsAccount = @@default_savings
    end

    #Sets customer name
    def set_name(name : String)
        @name = name
    end

    #Gets customer name
    def get_name
        @name
    end

    #Sets the customers checking account
    def set_checking(c_account : Account)
        @CheckingAccount = c_account   
    end

    #Sets the customers saving account
    def set_saving(s_account : Account)
        @SavingsAccount = s_account
    end

    #Gets the customers checking account
    def get_checking
        @CheckingAccount
    end

    #gets the customers savings acount
    def get_saving 
        @SavingsAccount
    end

    #Returns the checking balance
    def get_checking_balance
        @CheckingAccount.get_balance
    end

    #returns the savings balance
    def get_saving_balance
        @SavingsAccount.get_balance
    end

    #Tostring method
    def to_s
        return "Customer: "+@name+", Checking Balance: "+get_checking_balance.to_s+", Savings Balance: "+get_saving_balance.to_s+"."
    end
end



##Main program loop:
this_bank = Bank.new("Bank of Doves",0.02)
input = " "
while input != "Q" && input != "q"
    puts " "
    puts "Welcome to "+this_bank.get_name+". Please enjoy your stay."
    puts "What is your inquiry?"
    print "(B)ank settings, (A)ccounts settings, (I)nvestment details, (M)ake a deposit/withdraw, (Q)uit : "
    input = gets.not_nil!

    # Bank Settings
    if input == "B" || input == "b"
        input = " "
        while input != "B" && input != "b"
            puts " "
            puts "What would you like to do with the Bank?"
            print "(E)dit bank name, (A)dd a customer, (D)elete a customer, (B)ack : "
            input = gets.not_nil!
            puts " "
            
            #Changing Bank Name
            if input == "E" || input == "e"
                print "Enter the new bank name: "
                this_bank.set_name(gets.not_nil!)

            #Add a customer
            elsif input == "A" || input == "a"
                this_cust = Customer.new
                print "Add the customer's name (We do not allow duplicates): "
                customer_name = gets.not_nil!

                #Checks if name is in customers
                customers = this_bank.customer_list
                size = customers.size
                pos = 0
                contains = false
                until pos >= size
                    if customer_name == customers[pos].get_name
                        contains = true
                    end
                    pos += 1
                end

                #IF the name isn't present in customers
                if contains == false
                    this_cust.set_name(customer_name)
                    print "Add "+this_cust.get_name+"'s checking balance: "
                    this_cust.set_checking(CheckingAccount.new(gets.not_nil!.to_f64.round(2)))
                    print "Add "+this_cust.get_name+"'s saving balance: "
                    this_cust.set_saving(SavingsAccount.new(gets.not_nil!.to_f64.round(2)))
                    this_bank.add_cust(this_cust)
                    puts "Thank you for successfully adding a customer"
                else
                    puts "This name is already in use, returning to previous menu"
                end

            #Deletes all accounts with input name
            elsif input == "D" || input == "d" 
                print "Enter the customer name to be deleted: "
                input = gets.not_nil!
                puts "Successfully deleted "+ this_bank.delete_cust(input).to_s + " accounts."

            #Returns the user to the main input screen
            elsif input == "B" || input == "b"
                puts "Returning to main feature..."
            #Unrecognized input
            else
                puts "Unrecognized character, please try again."
            end
        end
        input = " "
    end

    # Account settings
    if input == "A" || input == "a"
        input = " "
        while input != "B" && input != "b"
            puts " "
            puts "What would you like to do with accounts?"
            print "(S)how all accounts, (F)ind accounts from name, (B)ack: "
            input = gets.not_nil!
            puts " "
            
            #Displays every customer + account
            if input == "S" || input == "s"
                puts "Displaying the full list of accounts: "
                display = this_bank.customer_list
                size = display.size
                pos = 0
                until pos >= size
                    puts display[pos].to_s
                    pos += 1
                end

            #Displays every customer + account from an input name
            elsif input == "F" || input == "f"
                print "Please enter the name of the account you wish to see: "
                name = gets.not_nil!
                display = this_bank.customer_list
                size = display.size
                pos = 0
                until pos >= size
                    if name == display[pos].get_name
                        puts display[pos].to_s
                    end
                    pos += 1
                end
            
            #returns to the original program
            elsif input == "B" || input == "b"
                puts "Returning to main feature..."
            #Unrecognized input
            else
                puts "Unrecognized character, please try again."
            end
        end
    input = " "
    end

    #Investment details
    if input == "I" || input == "i"
        input = " "
        while input != "B" && input != "b"
            puts " "
            puts "What would you like to see in investments?"
            print "(C)hange accruement rate, (A)ccrue, (B)ack: "
            input = gets.not_nil!
            puts " "

            #Change the accruement rate
            if input == "C" || input == "c"
                print "What would you like to change the accruement rate to: "
                input = gets.not_nil!.to_f64.round(2)
                this_bank.set_accrue_rate(input)
                puts "Accruement rate set to: "+input.to_s
            #Accrue every savings account balance (NOT CHECKING ACCOUNTS)
            elsif input == "A" || input == "a"
                customers = this_bank.customer_list
                size = customers.size
                pos = 0
                until pos >= size
                    customers[pos].get_saving.accrue(this_bank.get_accrue_rate)
                    pos += 1
                end
                puts "Successfully accrued all savings accounts"
            #returns to the original program
            elsif input == "B" || input == "b"
                puts "Returning to main feature..."
            #Unrecognized input
            else
                puts "Unrecognized character, please try again."
            end
        end
    input = " "
    end

    
    #Deposit or withdrawal
    if input == "M" || input == "m"
        input = " "
        while input != "B" && input != "b"
            puts " "
            puts "Deposit or Withdraw?"
            print "(D)eposit, (W)ithdraw, (B)ack: "
            input = gets.not_nil!
            puts " "

            #Make a Deposit
            if input == "D" || input == "d"
                puts " "
                print "What's your account name? "
                accname = gets.not_nil!
                print "Deposit into (S)avings or (C)hecking? "
                input = gets.not_nil!
                print "How much would you like to deposit? "
                dep = gets.not_nil!.to_f64.round(2)

                #Savings
                if input == "S" || input == "s"
                    customers = this_bank.customer_list
                    size = customers.size
                    pos = 0
                    until pos >= size
                        if accname == customers[pos].get_name
                            customers[pos].get_saving.deposit(dep)
                        end
                        pos += 1
                    end
                #Checking
                elsif input == "C" || input == "c"
                    customers = this_bank.customer_list
                    size = customers.size
                    pos = 0
                    until pos >= size
                        if accname == customers[pos].get_name
                            customers[pos].get_checking.deposit(dep)
                        end
                        pos += 1
                    end
                #unrecognized char
                else
                    puts "Unrecognized character, returning to previous menu."
                end
            #Withdraw
            elsif input == "W" || input == "w"
                puts " "
                print "What's your account name? "
                accname = gets.not_nil!
                print "Withdraw from (S)avings or (C)hecking? "
                input = gets.not_nil!
                print "How much would you like to withdraw? "
                wit = gets.not_nil!.to_f64.round(2)

                #Savings
                if input == "S" || input == "s"
                    customers = this_bank.customer_list
                    size = customers.size
                    pos = 0
                    until pos >= size
                        if accname == customers[pos].get_name
                            customers[pos].get_saving.withdraw(wit)
                        end
                        pos += 1
                    end
                #Checking
                elsif input == "C" || input == "c"
                    customers = this_bank.customer_list
                    size = customers.size
                    pos = 0
                    until pos >= size
                        if accname == customers[pos].get_name
                            customers[pos].get_checking.withdraw(wit)
                        end
                        pos += 1
                    end
                #unrecognized char
                else
                    puts "Unrecognized character, returning to previous menu."
                end
            #returns to the original program
            elsif input == "B" || input == "b"
                puts "Returning to main feature..."
            #Unrecognized input
            else
                puts "Unrecognized character, please try again."
            end
        end
    input = " "
    end

    
end

puts " "
puts "Thank you for using our banking tool."