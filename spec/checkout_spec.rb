require 'spec_helper'

RSpec.describe Checkout do
  subject(:checkout){ Checkout.new(promotional_rules) }
  let(:promotional_rules){
    module DummyPromotionalRules
      def apply_fifty_percent_discount(total)
        if total > 1000
          total = total - (total / 50)
        end
        total
      end
    end
  }

  it 'has an empty basket' do
    expect(checkout.basket).to be_empty
  end

  describe '.scan' do
    subject(:scan){ checkout.scan(item_code) }

    context 'when the item exists' do
      let(:item_code) { '001' }

      it 'adds the item code to the basket' do
        expect{scan}.to change{checkout.basket}.from([]).to([item_code])
      end
    end

    context 'when the item does not exist' do
      let(:item_code){ '004' }

      it 'does not add the item code to the basket' do
        expect{scan}.to_not change{checkout.basket}
      end
    end
  end

end
