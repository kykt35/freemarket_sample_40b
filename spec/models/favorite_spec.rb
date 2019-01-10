require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe '#create' do

    context 'can save' do
      it 'is valid with a user, item' do
        user = create(:user)
        seller = create(:user)
        item = create(:item, :image, seller: seller)
        favorite = Favorite.new(user: user, item: item)
        expect(favorite).to be_valid

      end
    end
  end
end
