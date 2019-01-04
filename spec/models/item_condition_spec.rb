require 'rails_helper'

RSpec.describe ItemCondition, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with a text' do
        item_condition = build(:item_condition)
        expect(item_condition).to be_valid
      end
    end
    context 'can not save' do
      it 'is invalid without text' do
        item_condition = build(:item_condition, text: nil)
        item_condition.valid?
        expect(item_condition.errors[:text]).to include("can't be blank")
      end
    end
  end
end
