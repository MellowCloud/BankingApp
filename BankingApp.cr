# Creation of a banking app
# Goal is to create a loop to add and inquire about bank accounts

class Bank
    @@default_accrue_rate = 0.02
    @@default_bank_name = "Bank of Doves"

    #initializes the new Bank
    def initialize(bank_name : String, accrue_rate : Float64)
        @name = bank_name || @@default_bank_name
        @customer = [] of Customer
        @accrueRate = accrue_rate || @@default_accrue_rate
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
        @accrueRate = rate
    end

    #Gets the present accrue rate
    def get_accrue_rate
        @accrueRate
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

    #tostring method
    def to_s
        return "Bank Name: "+@name
    end

end

#A module with functions for both Savings and Checking Accounts
module Account
    def get_balance
        @balance
    end

    def set_balance(bal : Float64)
        @balance = bal
    end

    def deposit(dep : Float64)
        @balance += dep
    end

    def withdraw(wit : Float64)
        @balance -= wit
    end
end

#Class definition of SavingsAccount
class SavingsAccount
    include Account

    def initialize(bal : Float64)
        @balance = bal
    end
end

#Class definition of CheckingAccount
class CheckingAccount
    include Account

    def initialize(bal : Float64)
        @balance = bal
    end
end

class Customer
    @@default_name = "Nameless"
    def initialize
        @name = @@default_name
        @CheckingAccount
        @SavingsAccount
    end

    def set_name(name : String)
        @name = name
    end

    def get_name
        @name
    end

    def set_checking(c_account : Account)
        @CheckingAccount = c_account   
    end

    def set_saving(s_account : Account)
        @SavingsAccount = s_account
    end
end

this_bank = Bank.new("Bank of Doves",0.02)
input = " "
while input != "Q" && input != "q"
    puts " "
    puts "Welcome to "+this_bank.get_name+". Please enjoy your stay."
    puts "What is your inquiry?"
    print "(B)ank settings, (A)ccounts list, (I)nvestment details, (M)ake a deposit/withdraw, (Q)uit : "
    input = gets.not_nil!

    # Bank Settings
    if input == "B" || input == "b"
        input = " "
        while input != "B" && input != "b"
            puts " "
            puts "What would you like to do with the Bank?"
            print "(E)dit bank name, (A)dd a customer, (B)ack : "
            input = gets.not_nil!
            
            #Changing Bank Name
            if input == "E" || input == "e"
                print "Enter the new bank name: "
                this_bank.set_name(gets.not_nil!)

            #Add a customer
            elsif input == "A" || input == "a"
                this_cust = Customer.new
                print "Add the customer's name: "
                this_cust.set_name(gets.not_nil!)
                print "Add "+this_cust.get_name+"'s checking balance: "
                this_cust.set_checking(CheckingAccount.new(gets.not_nil!.to_f64))
                print "Add "+this_cust.get_name+"'s saving balance: "
                this_cust.set_saving(SavingsAccount.new(gets.not_nil!.to_f64))
                puts "Thank you for successfully adding a customer"
            
            #Returns the user to the main input screen
            elsif input == "B" || input == "b"
                puts "Returning to main feature..."
            else
                puts "Unrecognized character, please try again."
            end
        end
        input = " "
    end
    if input == "A" || input == "a"
        input = " "
        while input != "B" && input != "b"
            puts " "
            puts "What would you like to do with accounts?"
            print "(D)elete a customer and its accounts, (S)how all accounts, (F)ind accounts from name, (B)ack:"
            input = gets.not_nil!
            if input == "D" || input == "d" 
                puts "WARNING: This will delete ALL customers and accounts with this name"
                print "Enter the customer name to be deleted: "
                input = gets.not_nil!
                this_bank.delete_cust(input)

            elsif input == "S" || input == "s"

            elsif input == "F" || input == "f"
            
            elsif input == "B" || input == "b"
            
            end
        end
    input = " "
    end
end

