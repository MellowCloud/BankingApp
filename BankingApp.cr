# Creation of a banking app
# Goal is to create a loop to add and inquire about bank accounts

class Bank

    #initializes the new Bank
    def initialize
        @name = "Bank of Doves"
        @customers = [] of Customers
        @accrueRate = 0.02
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

    def get_accrue_rate
        @accrueRate
    end

end

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

class SavingsAccount
    include Account

end

class CheckingAccount
    include Account

    def initialize
        @balance = 0
    end
end

class Customers
    def initialize
        @name = "Nameless"
        @CheckingAccount
        @SavingsAccount
    end

    def set_name
        
    end
end