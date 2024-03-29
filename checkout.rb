require_relative('promotional_rules')
class Checkout
  attr_reader :basket

  ITEMS = [
      {code: '001', name: 'Very cheap chair', price: 925},
      {code: '002', name: 'Little table', price: 4500},
      {code: '003', name: 'Funky table', price: 1995}
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

  def total
    return 0 if basket.empty?
    apply_discounts
  end

  private

  def apply_discounts
    original_total = calculate_original_total
    @promotional_rules.apply_discounts(total: original_total, item_codes: basket)
  end

  def calculate_original_total
    @basket.map{|item_code|
      ITEMS.detect{|item| item[:code] == item_code }[:price]
    }.reduce(0, :+)
  end
end
