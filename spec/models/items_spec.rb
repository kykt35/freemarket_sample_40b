require 'rails_helper'
RSpec.describe Item do
  describe '#show' do
    context 'can save' do
      it 'is valid with parameter' do
      	item = build(:item)
      	expect(item).to be_valid
      end
      it 'is valid with brand nil' do
        item = build(:item,brand_id: nil)
        expect(item).to be_valid
      end
    end
  	context 'can not save' do
  	  it 'is invalid with name nil' do
  	  	item = build(:item,name: nil)
	    item.valid?
	    expect(item.errors[:name]).to include("can't be blank")
      end
      it 'is invalid with seller nil' do
	    item = build(:item,seller_id: nil)
	    item.valid?
	    expect(item.errors[:seller_id]).to include("can't be blank")
      end
      it 'is invalid with category nil' do
	    item = build(:item,category_id: nil)
	    item.valid?
	    expect(item.errors[:category_id]).to include("can't be blank")
      end
      it 'is invalid with size nil' do
	    item = build(:item,size_id: nil)
	    item.valid?
	    expect(item.errors[:size_id]).to include("can't be blank")
      end
      it 'is invalid with condition nil' do
	    item = build(:item,item_condition_id: nil)
	    item.valid?
	    expect(item.errors[:item_condition_id]).to include("can't be blank")
      end
      it 'is invalid with postage nil' do
	    item = build(:item,postage_select_id: nil)
	    item.valid?
	    expect(item.errors[:postage_select_id]).to include("can't be blank")
      end
      it 'is invalid with shipping nil' do
	    item = build(:item,shipping_id: nil)
	    item.valid?
	    expect(item.errors[:shipping_id]).to include("can't be blank")
      end
      it 'is invalid with prefecture nil' do
	    item = build(:item,prefecture_id: nil)
	    item.valid?
	    expect(item.errors[:prefecture_id]).to include("can't be blank")
      end
      it 'is invalid with leadtime nil' do
	    item = build(:item,leadtime_id: nil)
	    item.valid?
	    expect(item.errors[:leadtime_id]).to include("can't be blank")
      end
      it 'is invalid with price nil' do
	    item = build(:item,price: nil)
	    item.valid?
	    expect(item.errors[:price]).to include("can't be blank")
      end
      it 'is invalid with description nil' do
        item = build(:item,description: nil)
	    item.valid?
	    expect(item.errors[:description]).to include("can't be blank")
      end
  	end
  end
end