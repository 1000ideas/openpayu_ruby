module OpenPayU
  class Cart
    def initialize(*items)
      @options = items.extract_options!
      @items = items.flatten
    end

    def to_hash 
      { 
        'GrandTotal' => grand_total,
        'CurrencyCode' => Item.currency,
        'ShoppingCartItems' => {
          'ShoppingCartItem' => @items.map(&:to_hash)
        }
      }
    end

    delegate :each_pair, to: :to_hash

    private

    def grand_total
      @items.inject(0) do |memo, item|
        memo + (item.gross*100).to_i
      end
    end 

  end
end