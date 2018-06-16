require 'spec_helper'

RSpec.describe PromotionalRules do
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
end
