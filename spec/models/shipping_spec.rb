require 'rails_helper'

RSpec.describe Shipping, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with a text' do
        shipping = build(:shipping)
        expect(shipping).to be_valid
      end
    end
    context 'can not save' do
      it 'is invalid without text' do
        shipping = build(:shipping, text: nil)
        shipping.valid?
        expect(shipping.errors[:text]).to include("can't be blank")
      end
    end
  end
end
