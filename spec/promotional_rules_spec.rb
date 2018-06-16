require 'spec_helper'

RSpec.describe PromotionalRules do
  subject(:promotional_rules) { described_class.new(items: items) }
  let(:items) { [] }

  it 'must be given items' do
    expect { promotional_rules }.
        to raise_error(ArgumentError, 'All items must be an Item')
  end
end
