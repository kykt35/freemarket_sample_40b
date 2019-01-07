require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid to create the grandchild category' do
        category = build(:category_grandchild, name: "かてごり")
        expect(category).to be_valid
      end
      it 'is valid to create the parent and granparent' do
        category = build(:category_grandchild, name: "かてごり")
        expect(category.parent).to be_valid
        expect(category.parent.parent).to be_valid
      end
      it 'is valid to create the child category' do
        category = build(:category_child, name: "かてごり")
        expect(category).to be_valid
      end
      it 'is valid to create the parent, not create granparent' do
        category = build(:category_child, name: "かてごり")
        expect(category.parent).to be_valid
        expect(category.parent.parent).to eq nil
      end
      it 'is valid to create the parent' do
        category = build(:category, name: "かてごり")
        expect(category).to be_valid
      end
      it 'is valid to not create the parent ' do
        category = build(:category, name: "かてごり")
        expect(category.parent).to eq nil

      end
    end
    context 'can not save' do
      it 'is invalid to create the grandchild category without name' do
        category = build(:category_grandchild, name: nil)
        category.valid?
        expect(category.errors[:name]).to include("can't be blank")
      end
      it 'is invalid to create the child category without name' do
        category = build(:category_child, name: nil)
        category.valid?
        expect(category.errors[:name]).to include("can't be blank")
      end
      it 'is invalid to create the parent category without name' do
        category = build(:category, name: nil)
        category.valid?
        expect(category.errors[:name]).to include("can't be blank")
      end
    end
  end
end
