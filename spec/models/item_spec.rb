require 'rails_helper'

describe Item do
  let(:seller) { create(:user) }
  describe '#create' do
    context 'can save' do
      it "is valid with parameter" do
        item = build(:item, :image, seller_id: seller.id)
        expect(item).to be_valid
      end
      it "is valid with brand nil" do
        item = build(:item, :image, brand: nil, seller_id: seller.id)
        expect(item).to be_valid
      end
      it "is valid with size nil" do
        item = build(:item, :image, size_id: nil, seller_id: seller.id)
        expect(item).to be_valid
      end
      it 'is valid with a name that has less than 40 char'do
        item = build(:item, :image, name: Faker::String.random(40), seller_id: seller.id)
        expect(item).to be_valid
      end
      it 'is valid with a description that has less than 1000 char'do
        item = build(:item, :image, description: Faker::String.random(1000), seller_id: seller.id)
        expect(item).to be_valid
      end
      it "is valid with a image jpeg" do
        item = build(:item, :image_jpeg, seller_id: seller.id)
        expect(item).to be_valid
      end
      it "is valid with a image png" do
        item = build(:item, :image_png, seller_id: seller.id)
        expect(item).to be_valid
      end
      it "is valid with 10 images" do
        item = build(:item, seller_id: seller.id)
        10.times{
        item.images.attach(
          fixture_file_upload("#{::Rails.root}/spec/fixtures/sample.jpg", "image/jpg"))
        }
        expect(item).to be_valid
      end
    end

    context 'can not save' do
      it "is invalid with name nil" do
        item = build(:item, :image, name: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:name]).to include("can't be blank")
      end
      it "is invalid with a name that has more than 40 char" do
        item = build(:item, :image, name: Faker::String.random(41), seller_id: seller.id)
        item.valid?
        expect(item.errors[:name][0]).to include("is too long")
      end
      it "is invalid with description nil" do
        item = build(:item, :image, description: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:description]).to include("can't be blank")
      end
      it "is invalid with a description that has more than 1000 char" do
        item = build(:item, :image, description: Faker::String.random(1001), seller_id: seller.id)
        item.valid?
        expect(item.errors[:description][0]).to include("is too long")
      end
      it "is invalid with price nil" do
        item = build(:item, :image, price: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:price]).to include("can't be blank")
      end
      it "is invalid with price char" do
        item = build(:item, :image, price: "aaa", seller_id: seller.id)
        item.valid?
        expect(item.errors[:price]).to include("is not a number")
      end
      it "is invalid with category_id nil" do
        item = build(:item, :image, category_id: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:category_id]).to include("can't be blank")
      end
      it "is invalid with item_condition_id nil" do
        item = build(:item, :image, item_condition_id: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:item_condition_id]).to include("can't be blank")
      end
      it "is invalid with postage_select_id nil" do
        item = build(:item, :image, postage_select_id: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:postage_select_id]).to include("can't be blank")
      end
      it "is invalid with shipping_id nil" do
        item = build(:item, :image, shipping_id: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:shipping_id]).to include("can't be blank")
      end
      it "is invalid with prefecture_id nil" do
        item = build(:item, :image, prefecture_id: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:prefecture_id]).to include("can't be blank")
      end
      it "is invalid with leadtime_id nil" do
        item = build(:item, :image, leadtime_id: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:leadtime_id]).to include("can't be blank")
      end
      it "is invalid with seller_id nil" do
        item = build(:item, :image, seller_id: nil,)
        item.valid?
        expect(item.errors[:seller_id]).to include("can't be blank")
      end
      it "is invalid with no image" do
        item = build(:item, seller_id: seller.id)
        item.valid?
        expect(item.errors[:images]).to include("images cant' be blank")
      end
      it "is invalid with invalid image_type txt" do
        item = build(:item, :text , seller_id: seller.id)
        item.valid?
        expect(item.errors[:images]).to include("jpg/png only")
      end
      it "is invalid with invalid image_type gif" do
        item = build(:item, :image_gif , seller_id: seller.id)
        item.valid?
        expect(item.errors[:images]).to include("jpg/png only")
      end
      it "is invalid with invalid image file size over 10MB" do
        item = build(:item, :image_10m , seller_id: seller.id)
        item.valid?
        expect(item.errors[:images]).to include("too large")
      end
      it "is invalid with invalid images length over 10" do
        item = build(:item , seller_id: seller.id)
        11.times{
          item.images.attach(
          fixture_file_upload("#{::Rails.root}/spec/fixtures/sample.jpg", "image/jpg"))
        }
        item.valid?
        expect(item.errors[:images][0]).to include("is too long")
      end
    end
  end
  describe '#favorite' do
    context "can favorite" do
      it "is valid" do
        item = create(:item ,:image , seller_id: seller.id)
        user = create(:user)
        expect(item.favorite(user)).to be_valid
      end
      it "count up Favorite" do
        item = create(:item ,:image , seller_id: seller.id)
        user = create(:user)
        expect{item.favorite(user)}.to change(Favorite, :count).by(1)
      end
      it "count up item.favorites" do
        item = create(:item ,:image , seller_id: seller.id)
        user = create(:user)
        expect{item.favorite(user)}.to change(item.favorites, :count).by(1)
      end
      it "count up Favorite" do
        item = create(:item ,:image , seller_id: seller.id)
        user = create(:user)
        expect{item.favorite(user)}.to change(user.favorites, :count).by(1)
      end
    end
    context "can unfavorite" do
      it "is valid" do
        item = create(:item ,:image , seller_id: seller.id)
        user = create(:user)
        Favorite.create(item: item, user: user)
        expect(item.unfavorite(user)).to be_valid
      end
      it "count up Favorite" do
        item = create(:item ,:image , seller_id: seller.id)
        user = create(:user)
        Favorite.create(item: item, user: user)
        expect{item.unfavorite(user)}.to change(Favorite, :count).by(-1)
      end
      it "count up item.favorites" do
        item = create(:item ,:image , seller_id: seller.id)
        user = create(:user)
        Favorite.create(item: item, user: user)
        expect{item.unfavorite(user)}.to change(item.favorites, :count).by(-1)
      end
      it "count up Favorite" do
        item = create(:item ,:image , seller_id: seller.id)
        user = create(:user)
        Favorite.create(item: item, user: user)
        expect{item.unfavorite(user)}.to change(user.favorites, :count).by(-1)
      end
    end
  end

end
