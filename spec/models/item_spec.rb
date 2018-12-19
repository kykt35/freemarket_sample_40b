require 'rails_helper'

describe Item do
  let(:seller) { create(:user) }
  describe '#create' do

    context 'can save' do
      it "is valid with valid parameter" do

        item = build(:item, seller_id: seller.id)
        expect(item).to be_valid

      end
      it "is valid with brand nil" do
        item = build(:item, brand_id: nil, seller_id: seller.id)
        expect(item).to be_valid
      end
      it "is valid with size nil" do
        item = build(:item, size_id: nil, seller_id: seller.id)
        expect(item).to be_valid
      end
    end

    context 'can not save' do
      it "is invalid with name nil" do
        item = build(:item, name: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:name]).to include("can't be blank")
      end
      it "is invalid with description nil" do
        item = build(:item, description: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:description]).to include("can't be blank")
      end
      it "is invalid with price nil" do
        item = build(:item, price: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:price]).to include("can't be blank")
      end
      it "is invalid with price char" do
        item = build(:item, price: "aaa", seller_id: seller.id)
        item.valid?
        expect(item.errors[:price]).to include("is not a number")
      end
      it "is invalid with category_id nil" do
        item = build(:item, category_id: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:category_id]).to include("can't be blank")
      end
      it "is invalid with item_condition_id nil" do
        item = build(:item, item_condition_id: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:item_condition_id]).to include("can't be blank")
      end
      it "is invalid with postage_select_id nil" do
        item = build(:item, postage_select_id: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:postage_select_id]).to include("can't be blank")
      end
      it "is invalid with shipping_id nil" do
        item = build(:item, shipping_id: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:shipping_id]).to include("can't be blank")
      end
      it "is invalid with prefecture_id nil" do
        item = build(:item, prefecture_id: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:prefecture_id]).to include("can't be blank")
      end
      it "is invalid with leadtime_id nil" do
        item = build(:item, leadtime_id: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:leadtime_id]).to include("can't be blank")
      end
      it "is invalid with seller_id nil" do
        item = build(:item, seller_id: nil,)
        item.valid?
        expect(item.errors[:seller_id]).to include("can't be blank")
      end
      it "is invalid with images nil" do
        item = build(:item, images: nil, seller_id: seller.id)
        item.valid?
        expect(item.errors[:images_attachments]).to include("is invalid")
      end
    end

  end
end
