

module OpenPayU
  class Item
    @@currency = 'PLN'
    mattr_accessor :currency

    def initialize(name, price, quantity = 1, tax = 23.0)
      @name = name
      @net = price
      @tax_rate = tax.to_f
      @quantity = quantity
    end

    def gross
      @net + tax_value
    end

    def tax_value
      @net*(@tax_rate/100.0)
    end

    def to_hash
      { 
        'Quantity' => @quantity,
        'Product' => {
          'Name' => @name,
          'UnitPrice' => {
            'Gross' => (gross*100).to_i,
            'Net' => (@net*100).to_i, 
            'Tax' => (tax_value*100).to_i, 
            'TaxRate' => @tax_rate, 
            'CurrencyCode' => self.class.currency
          }
        }
      }
    end

    delegate :each_pair, to: :to_hash
  end
end