require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #index" do
    let(:user) { create(:user)}
    let(:item) { create(:item, :image, seller_id: user.id, ) }
    it "200 responseが返ってくること" do
      get :index
      expect(response).to have_http_status "200"
    end

    it "表示が成功する" do
      get :index
      expect(response).to be_success
    end

    it 'indexテンプレートを表示すること' do
      get :index
      expect(response).to render_template :index
    end

    it '@itemsがデータベースから取り出されて表示されること' do
      get :index
      expect(controller.instance_variable_get("@items")).to include item
    end
  end
end




