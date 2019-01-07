require 'rails_helper'

RSpec.describe PostageSelect, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with a text' do
        postage_select = build(:postage_select)
        expect(postage_select).to be_valid
      end
    end
    context 'can not save' do
      it 'is invalid without text' do
        postage_select = build(:postage_select, text: nil)
        postage_select.valid?
        expect(postage_select.errors[:text]).to include("can't be blank")
      end
    end
  end
end
