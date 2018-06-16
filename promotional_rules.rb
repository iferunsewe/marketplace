module PromotionalRules
  def self.apply_over_sixty_discount(total)
    if total > 6000
      total = total - (total / 10)
    end
    total
  end

end
