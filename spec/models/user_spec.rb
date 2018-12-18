require 'rails_helper'
RSpec.describe User do

  describe '#create' do
    context 'can save' do
      it 'is valid with a nickname, email, password, password_confirmation' do
        user = build(:user)
        expect(user).to be_valid
      end
      it 'is valid with a nickname that has less than 20 charactors'do
        user = build(:user, nickname: Faker::String.random(20))
        user.valid?
        expect(user).to be_valid
      end
      it 'is vaild with a password that has more than 6 charactors'do
        user = build(:user, password: "a0a0a0",password_confirmation: "a0a0a0")
        user.valid?
        expect(user).to be_valid
      end
      it 'is valid with a password that has nunber and alphabet'do
        user = build(:user, password: "a0a0a0",password_confirmation: "a0a0a0")
        user.valid?
        expect(user).to be_valid
      end
    end
    context 'can not save' do
      it "is invalid without a nickname" do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user.errors[:nickname]).to include("can't be blank")
      end
      it "is invalid without a email" do
        user = build(:user,email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end
      it "is invalid without a password" do
        user = build(:user,password: nil)
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end
      it "is invalid without a password_confirmation although with a password" do
        user = build(:user,password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end
      it "is invalid with a nickname that has more than 20 charactors" do
        user = build(:user, nickname: Faker::String.random(21))
        user.valid?
        expect(user.errors[:nickname][0]).to include("is too long")
      end
      it "is invalid with a password that has less than 5 characters " do
        user = build(:user, password: "a0a0a", password_confirmation: "a0a0a")
        user.valid?
        expect(user.errors[:password][0]).to include("is too short")
      end
      it "is invalid with a password that has only nunber " do
        user = build(:user, password: "000000", password_confirmation: "000000")
        user.valid?
        expect(user.errors[:password][0]).to include("英数混在で入力してください")
      end
      it "is invalid with a password that has only alphabet " do
        user = build(:user, password: "aaaaaa", password_confirmation: "aaaaaa")
        user.valid?
        expect(user.errors[:password][0]).to include("英数混在で入力してください")
      end
      it "is invalid with a password that not has number and alphabet " do
        user = build(:user, password: "//////", password_confirmation: "//////")
        user.valid?
        expect(user.errors[:password][0]).to include("英数混在で入力してください")
      end
    end
  end
end
