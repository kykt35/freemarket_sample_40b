require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with a name' do
        prefecture = build(:prefecture)
        expect(prefecture).to be_valid
      end
    end
    context 'can not save' do
      it 'is invalid without text' do
        prefecture = build(:prefecture, name: nil)
        prefecture.valid?
        expect(prefecture.errors[:name]).to include("can't be blank")
      end
    end
  end
end
