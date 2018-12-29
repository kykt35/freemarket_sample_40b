require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with a user, item' do
        like = build(:like)
        expect(like).to be_valid
      end
      it 'is invalid without user and item' do
        like = build(:like, user: nil, item: nil)
        like.valid?
        expect(like.errors[:user]).to include("must exist")
        expect(like.errors[:item]).to include("must exist")
      end
      it 'is invalid without user' do
        binding.pry
        like = build(:like, user: nil)
        like.valid?
        expect(like.errors[:user]).to include("must exist")
      end
      it 'is invalid without item' do
        like = build(:like, item: nil)
        like.valid?
        expect(like.errors[:item]).to include("must exist")
      end
      it 'is invalid ' do
        like1 = create(:like)
        like2 = build(:like)
        like2.valid?
        expect(like2.errors[:user]).to include("must exist")
      end
    end
  end
end
