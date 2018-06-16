class PromotionalRules
  def initialize(items:)
    raise ArgumentError, "All items must be an Item" unless contains_items?(items)

  end

  private

  def contains_items?(items)
    !items.empty? && items.all?{|item| item.is_a? Item}
  end

end
