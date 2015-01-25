module BankScrap
  class Account
    attr_accessor :id, :name, :balance, :currency, 
                  :available_balance, :description,
                  :transactions
    
    def initialize(params = {})
      params.each { |key, value| send "#{key}=", value }
    end
  end
end

