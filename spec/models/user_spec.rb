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
  describe".create_from_auth!(auth)" do
    let!(:user){ user = create(:user, email: "aaaa@email.com")}
    auth = { "provider" => "test", "uid" => 1000000, "info" => { "email" => "sample@email.com", "name" => "test user" } }

    it "Usersテーブルに引数と同じemailがないとき、新たなuserを作ること" do
      User.create_from_auth!(auth)
      expect(User.last(1)).to eq User.where(email: "sample@email.com")
    end
    it "Usersテーブルに引数と同じemailがあるとき、それをuserとすること" do
      auth['info']['email'] = "aaaa@email.com"
      credential = User.create_from_auth!(auth)
      find_user = credential.user
      expect(find_user).to eq  User.find(user.id)
      auth = { "provider" => "test", "uid" => 1000000, "info" => { "email" => "sample@email.com", "name" => "test user" } }
    end
    it "SnsCredentialsテーブルに引数と同じproviderのuidとがないとき、新たなsns_credentialを作ること" do
      User.create_from_auth!(auth)
      expect(SnsCredential.last(1)).to eq SnsCredential.where(uid: 1000000, provider: "test")
    end
    it "SnsCredentialsテーブルに引数と同じuidが存在していても違うプロバイダーなら、新たなsns_credentialを作ること" do
      sns_credential = SnsCredential.create(uid: 1000000, provider: "test2", user_id: 1)
      User.create_from_auth!(auth).save
      expect(SnsCredential.last(1)).to eq SnsCredential.where(uid: 1000000, provider: "test")
    end
    it "SnsCredentialsテーブルに引数と同じproviderのuidとがあるとき、それをsns_credentialとすること" do
      sns_credential = SnsCredential.create(uid: 1000000, provider: "test", user_id: user.id)
      credential = User.create_from_auth!(auth)
      expect(credential).to eq sns_credential
    end
    auth = { "provider" => "test", "uid" => 1000000, "info" => { "email" => "sample@email.com", "name" => "test user" } }
    it "保存されるnicknameがスペースで区切られていたら、一番最初の区切りをnicknameにすること" do
      new_credential = User.create_from_auth!(auth)
      @user = new_credential.user
      expect(@user.nickname).to eq "test"
    end
  end
end
