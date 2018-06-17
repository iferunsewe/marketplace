require 'spec_helper'

RSpec.describe Checkout do
  subject(:checkout){ Checkout.new(DummyPromotionalRules) }
  module DummyPromotionalRules
    extend self
    def apply_discounts(total, _)
      apply_fifty_percent_discount(total)
    end

    def apply_fifty_percent_discount(total)
      if total > 1000
        total = total / 2
      end
      total
    end
  end

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

  describe '.total' do
    subject(:total){ checkout.total }

    it 'returns 0 when the basket is empty' do
      expect(total).to eq(0)
    end

    context 'when the basket has items and discounts are applied' do
      it 'returns a discounted total' do
        scan_item('001')
        scan_item('002')
        discounted_total = (get_item_price('001') + get_item_price('002')) / 2
        expect(total).to eq(discounted_total)
      end


    end

    context 'when the basket items and discounts are not applied' do
      it 'returns a total with no discounts' do
        scan_item('001')
        expect(total).to eq(get_item_price('001'))
      end
    end

    def get_item_price(item_code)
      Checkout::ITEMS.detect{|item| item[:code] == item_code}[:price]
    end

    def scan_item(item_code)
      checkout.scan(item_code)
    end
  end
end
