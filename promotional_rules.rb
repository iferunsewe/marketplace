module PromotionalRules
  def self.apply_over_sixty_discount(total)
    if total > 6000
      total = total - (total / 10)
    end
    total
  end

  def self.apply_more_than_two_vcc_discount(item_codes, total)
    vcc_count = item_codes.select {|code| code == '001'}.count
    if vcc_count > 1
      total = total - (vcc_count * 75)
    end
    total
  end
end
