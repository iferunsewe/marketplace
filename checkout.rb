require_relative('promotional_rules')
class Checkout
  attr_reader :basket

  ITEMS = [
      {code: '001', price: 925},
      {code: '002', price: 4500},
      {code: '003', price: 1995}
  ]

  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @basket = []
  end

  def scan(item_code)
    if ITEMS.map{|item| item[:code]}.include? item_code
      @basket << item_code
    end
  end
end