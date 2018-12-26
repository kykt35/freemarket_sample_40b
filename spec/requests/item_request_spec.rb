require 'rails_helper'

describe "Item", type: :request do
  let(:user) { create(:user)}
   describe 'POST#upload_image' do
    let(:params) {{image: fixture_file_upload("#{::Rails.root}/spec/fixtures/sample.jpg", "image/jpg")}}
     subject{
      post "/items/upload_image.json",params: params
    }
    context 'logged in' do
      before do
        sign_in user
      end
      context 'successfull' do
        it 'responce successfull ' do
          subject
          expect(response.status).to eq 200
        end
      end
      context 'can upload' do
        it "count up activestorage blob" do
          expect{ subject }.to change(ActiveStorage::Blob, :count).by(1)
        end
        it 'responce image.blob.key' do
          subject
          json = JSON.parse(response.body)
          expect(json.keys).to include('imageKey')
        end
      end
    end # logged in
    context 'not logged in' do
      it 'responce 401 ' do
        subject
        expect(response.status).to eq 401
      end
    end
  end # POST#upload_image
end
