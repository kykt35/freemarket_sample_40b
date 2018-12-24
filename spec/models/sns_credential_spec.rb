require 'rails_helper'

RSpec.describe SnsCredential, type: :model do
  describe '#create' do
    before do
      @user = create(:user)
    end
    context 'can save' do
      it 'is vaild with a user_id, uid, provider' do
        sns_credential = build(:sns_credential)
        expect(sns_credential).to be_valid
      end
      it 'is vaild with a same uid to a diffrent provider' do
        sns_credential = create(:sns_credential)
        other_sns_credential = build(:sns_credential,provider: "Test")
        expect(sns_credential).to be_valid
      end
    end
    context 'can not save' do
      it 'is invaild without a user_id' do
        sns_credential = build(:sns_credential,user_id: nil)
        sns_credential.valid?
        expect(sns_credential.errors[:user_id]).to include("can't be blank")
      end
      it 'is invaild without a uid'do
        sns_credential = build(:sns_credential,uid: nil)
        sns_credential.valid?
        expect(sns_credential.errors[:uid]).to include("can't be blank")
      end
      it 'is invaild without a provider' do
        sns_credential = build(:sns_credential,provider: nil)
        sns_credential.valid?
        expect(sns_credential.errors[:provider]).to include("can't be blank")
      end
      it 'is invalid with a duplicate uid to a same provider' do
        sns_credential = create(:sns_credential)
        other_sns_credential = build(:sns_credential)
        other_sns_credential.valid?
        expect(other_sns_credential.errors[:uid]).to include("has already been taken")
      end
    end
  end
end
