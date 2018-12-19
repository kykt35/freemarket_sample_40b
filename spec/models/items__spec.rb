require 'rails_helper'
RSpec.describe Item do

describe 'items#show' do
  let(:item) { Item.new }
    context 'can show' do
      it '全部見れる場合' do
        item
	　  expect(item).to be_valid
      end
      it '商品名が４０文字以内で入っている' do
        item(name: Faker::String.random(40))
	    user.valid?
	    expect(item).to be_valid
      end
      it '出品者が表示されている' do
	    item(saler_id: 1)
	    user.valid?
	    expect(item).to be_valid
      end
      it 'カテゴリーが選択されている' do
	    item(category_id: 1)
	    user.valid?
	    expect(item).to be_valid
	  end
	  it 'サイズが入っている' do
	    item(size_id: 1)
	    user.valid?
	    expect(item).to be_valid
      end
	  it '商品の状態が選択されている' do
	    item(item_condition_id: 1)
	    user.valid?
	    expect(item).to be_valid
	  end
	  it '配送料の負担が選択されている' do
	    item(postage_select_id: 1)
	    user.valid?
	    expect(item).to be_valid
	  end
	  it '配送の方法が選択されている' do
	    item(delivery_id: 1)
	    user.valid?
	    expect(item).to be_valid
	  end
	  it '発送元の地域が選択されている' do
	    item(post_prefecture: 1)
	    user.valid?
	    expect(item).to be_valid
	  end
	  it '発送日の目安が選択されている' do
	    item(leadtime: 1)
	    user.valid?
	    expect(item).to be_valid
	  end
	  it '価格が選択されている' do
	    item(amount: 5000)
	    user.valid?
	    expect(item).to be_valid
      end
      it '商品の説明が入っている(1000文字以内)' do
	    item(description: Faker::String.random(1000))
	    user.valid?
	    expect(item).to be_valid
      end
    end
  
  	context 'can not show' do
  	  it '商品名が入っていない' do
	    let(:item) { { name: nil} }
	    item.valid?
	    expect(user.errors[:name]).to include("can't be blank")
      end
      it '商品名の文字数オーバー' do
	    item(name: Faker::String.random(41))
	    user.valid?
	    expect(user.errors[:name]).to include("is too long")
      end
      it '出品者が入っていない' do
	    item(saler_id: nil)
	    user.valid?
	    expect(user.errors[:saler_id]).to include("can't be blank")
      end
      it 'カテゴリーが入っていない' do
	    item(category_id: nil)
	    user.valid?
	    expect(user.errors[:category_id]).to include("can't be blank")
      end
      it 'サイズが入っていない' do
	    item(size_id: nil)
	    user.valid?
	    expect(user.errors[:size_id]).to include("can't be blank")
      end
      it '出品状態が入っていない' do
	    item(item_condition_id: nil)
	    user.valid?
	    expect(user.errors[:item_condition_id]).to include("can't be blank")
      end
      it '配送料が入っていない' do
	    item(postage_select_id: nil)
	    user.valid?
	    expect(user.errors[:postage_select_id]).to include("can't be blank")
      end
      it '配送の方法が入っていない' do
	    item(delivery_id: nil)
	    user.valid?
	    expect(user.errors[:delivery_id]).to include("can't be blank")
      end
      it '発送元の地域が入っていない' do
	    item(post_prefecture: nil)
	    user.valid?
	    expect(user.errors[:post_prefecture]).to include("can't be blank")
      end
      it '発送日の目安が入っていない' do
	    item(leadtime: nil)
	    user.valid?
	    expect(user.errors[:leadtime]).to include("can't be blank")
      end
      it '価格が入っていない' do
	    item(amount: nil)
	    user.valid?
	    expect(user.errors[:amount]).to include("can't be blank")
      end
      it '説明が入っていない' do
        item(description: nil)
	    user.valid?
	    expect(user.errors[:description]).to include("can't be blank")
      end
      it '説明の文字数オーバー' do
	    item(description: Faker::String.random(1001))
	    user.valid?
	    expect(user.errors[:description]).to include("is too long")
      end
  	end
  end
end


















