module PromotionalRules
  extend self

  def apply_discounts(total:, item_codes:)
    discounted_total = apply_more_than_two_vcc_discount(total: total, item_codes: item_codes)
    apply_over_sixty_discount(discounted_total)
  end

  def apply_over_sixty_discount(total)
    if total > 6000
      total = total - (total / 10)
    end
    total
  end

  def apply_more_than_two_vcc_discount(total:, item_codes:)
    vcc_count = item_codes.select {|code| code == '001'}.count
    if vcc_count > 1
      total = total - (vcc_count * 75)
    end
    total
  end
end
