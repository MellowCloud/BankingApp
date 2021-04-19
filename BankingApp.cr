# Creation of a banking app
# Goal is to create a loop to add and inquire about bank accounts

class Bank

    #initializes the new Bank
    def initialize
        @name = "Bank of Doves"
        @accounts = [] of Account
    end

    def setName(name : String)
        @name = name
    end

    def getName
        @name
    end

end

class Account
    
end