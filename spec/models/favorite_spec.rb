require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with a user, item' do
        favorite = build(:favorite)
        expect(favorite).to be_valid
      end

      it 'is invalid without user' do
        favorite = build(:favorite, user: nil)
        favorite.valid?
        expect(favorite.errors[:user]).to include("must exist")
      end
      it 'is invalid without item' do
        favorite = build(:favorite, item: nil)
        favorite.valid?
        expect(favorite.errors[:item]).to include("must exist")
      end
      it 'is invalid without user and item' do
        favorite = build(:favorite, user: nil, item: nil)
        favorite.valid?
        expect(favorite.errors[:user_id]).to include("must exist")
        expect(favorite.errors[:item_id]).to include("must exist")
      end
      it 'is invalid ' do
        favorite1 = create(:favorite)
        favorite2 = build(:favorite)
        favorite2.valid?
        expect(favorite2.errors[:user]).to include("must exist")
      end
    end
  end
end
