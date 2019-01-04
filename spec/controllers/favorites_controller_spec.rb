require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  let(:user) { create(:user)}
  let(:item) { create(:item, :image)}

  describe "POST #create" do
    context "logged in" do
      before do
        login user
      end
      subject {
        post :create,
        params: {item_id: item.id},
        format: :js
      }
      it "returns http success" do
        subject
        expect(response).to have_http_status(:success)
      end
      it "render create" do
        subject
        expect(response).to render_template :create
      end
      it "assigns the required item to @item" do
        subject
        expect(assigns(:item)).to eq item
      end
      it "count up Favorite" do
        expect{ subject }.to change(Favorite, :count).by(1)
      end
      it "count up item.favorites" do
        expect{ subject }.to change(item.favorites, :count).by(1)
      end
      it "count up user.favorites" do
        expect{ subject }.to change(user.favorites, :count).by(1)
      end
    end
    context "not logged in" do
      subject {
        post :create,
        params: {item_id: item.id},
        format: :js
      }
      it "does not count up Favorite" do
        expect{ subject }.not_to change(Favorite, :count)
      end
      it "redirects to  new_user_session_path" do
        subject
        expect(response).to have_http_status(401)
      end
    end
  end
  describe "DELETE #destroy" do
    let!(:favorite) {Favorite.create(user: user, item: item)}
    context "logged in" do
      before do
        login user
      end
      subject {
        delete :destroy,
        params: {item_id: item.id, id: favorite.id},
        format: :js
      }
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "render destroy" do
        subject
        expect(response).to render_template :destroy
      end
      it "assigns the required item to @item" do
        subject
        expect(assigns(:item)).to eq item
      end
      it "count down Favorite" do
        expect{ subject }.to change(Favorite, :count).by(-1)
      end
      it "count down item.favorites" do
        expect{ subject }.to change(item.favorites, :count).by(-1)
      end
      it "count down user.favorites" do

        expect{ subject }.to change(user.favorites, :count).by(-1)
      end
    end
    context "not logged in" do
      subject {
        delete :destroy,
        params: {item_id: item.id, id: favorite.id},
        format: :js
      }
      it "does not count down Favorite" do
        expect{ subject }.not_to change(Favorite, :count)
      end
      it "redirects to  new_user_session_path" do
        subject
        expect(response).to have_http_status(401)
      end
    end
  end
end
