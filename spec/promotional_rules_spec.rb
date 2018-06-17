require 'spec_helper'

RSpec.describe PromotionalRules do
  describe '.apply_discounts' do
    subject(:apply_discounts) { PromotionalRules.apply_discounts(total: total, item_codes: item_codes) }

    context 'when there are discounts to be applied' do
      let(:item_codes){['001', '001', '002']}
      let(:total){ 6350 }
      it 'returns a discounted price' do
        more_than_two_vcc_discount_applied = PromotionalRules.apply_more_than_two_vcc_discount(total: total, item_codes: item_codes)
        over_sixty_discount_applied = PromotionalRules.apply_over_sixty_discount(more_than_two_vcc_discount_applied)
        expect(apply_discounts).to eq over_sixty_discount_applied
      end
    end

    context 'when there is no discount to be applied' do
      let(:item_codes){['001', '002']}
      let(:total){ 5425 }

      it 'returns the a non-discounted total' do
        expect(apply_discounts).to eq total
      end
    end
  end

  describe '.apply_over_sixty_discount' do
    subject(:apply_over_sixty_discount) { PromotionalRules.apply_over_sixty_discount(total) }

    context 'when there more the original total is more than 60' do
      let(:total){7000}
      it 'returns a 10% discounted total' do
        expect(apply_over_sixty_discount).to eq (total - (total / 10))
      end
    end

    context 'when there more the original total is less than 60' do
      let(:total){5000}
      it 'returns the same total' do
        expect(apply_over_sixty_discount).to eq (total)
      end
    end
  end

  describe '.apply_more_than_two_vcc_discount' do
    subject(:apply_more_than_two_vcc_discount) { PromotionalRules.apply_more_than_two_vcc_discount(total: total, item_codes: item_codes) }

    context 'when there is more than 1 very cheap chairs' do
      let(:item_codes){['001', '001', '002']}
      let(:total){ 6350 }
      it 'returns a discounted price where the chairs have a reduced price by 75' do
        amount_to_reduce = item_codes.select{|code| code == '001'}.count * 75
        expect(apply_more_than_two_vcc_discount).to eq total - amount_to_reduce
      end
    end

    context 'when there is less than 2 very cheap chairs' do
      let(:item_codes){['001', '002', '002']}
      let(:total){ 6350 }
      it 'returns the same total' do
        expect(apply_more_than_two_vcc_discount).to eq total
      end
    end
  end
end
