require 'rails_helper'

describe ItemsController, type: :controller do
  let(:user) { create(:user)}
  describe '#new' do
    context 'logged in' do
      before do
        login user
        get :new
      end
      it "assigns @item" do
        expect(assigns(:item)).to be_a_new(Item)
      end
      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end
    context 'not logged in' do
      before do
        get :new
      end
      it 'redirects to  new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end #'not logged in'
  end # '#new'

  describe '#create' do
    let(:uploading_file) {fixture_file_upload("#{::Rails.root}/spec/fixtures/sample.jpg", "image/jpg")}
    let(:uploaded_images) {[ActiveStorage::Blob.create_after_upload!(
                io: uploading_file.open,
                filename: uploading_file.original_filename,
                content_type: uploading_file.content_type).key]}
    let(:params) {{seller_id: user.id, item: attributes_for(:item, uploaded_images: uploaded_images)}}
    context 'logged in' do
     before do
        login user
      end
      context 'can save' do
        subject{
          post :create,
          params: params
        }
        it 'count up items' do
          expect{ subject }.to change(Item, :count).by(1)
        end
      end
      context 'can not save' do
        let(:invalid_params) {{seller_id: user.id, item: attributes_for(:item, :image, name: nil)}}
        subject {
          post :create,
          params: invalid_params
        }
        it 'does not count up' do
          expect{ subject }.not_to change(Item, :count)
        end
        it "renders new" do
          subject
          expect(response).to render_template :new
        end
      end
    end
    context 'not logged in' do
        subject{
          post :create,
          params: params
        }
      it 'does not count up' do
        expect{ subject }.not_to change(Item, :count)
      end
      it 'redirects to  new_user_session_path' do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#show' do
    context 'viewが正常か'  do
      it 'showの画面が表示できているか' do
        item = create(:item, :image, seller_id: user.id,name: "タイトル")
        get :show, params: {id: item.id}
        expect(response).to render_template :show
      end
      it 'タイトルを取得できるか' do
        item = create(:item, :image, seller_id: user.id,name: "タイトル")
        get :show, params: {id: item.id}
        expect(assigns(:item).name).to eq "タイトル"
      end
    end
  end

  describe '#destroy' do
    context '削除される' do
      before do
        login user
      end
      it 'itemテーブルから1つ情報が削除される' do
        item = create(:item, :image, seller_id: user.id)
        expect{
          delete :destroy, params: {id: item.id}
        }.to change(Item, :count).by(-1)
      end
      it '削除後にルートにリダイレクトされる' do
        item = create(:item, :image, seller_id: user.id)
        delete :destroy, params: {id: item.id}
        expect(response).to redirect_to(root_path)
      end
    end
    context '削除されない' do
      let(:user2) { create(:user)}
      it 'ログインしていないので削除できない' do
        item = create(:item, :image, seller_id: user.id)
        expect{
          delete :destroy, params: {id: item.id}
        }.not_to change(Item, :count)
      end
      it '違うユーザーの商品なので削除できない' do
        login user
        item = create(:item, :image, seller_id: user2.id)
        expect{
          delete :destroy, params: {id: item.id}
        }.not_to change(Item, :count)
      end
    end

  end

  describe '#edit' do
    context '@itemの情報が取れている' do
      it 'has a 200 status code' do
        expect(response).to have_http_status(:ok)
      end
      it 'assigns @item' do
        login user
        item = create(:item, :image, seller_id: user.id)
        get :edit, params: {id: item.id}
        expect(assigns(:item)).to eq item
      end
      it 'renders the :edit template' do
        login user
        item = create(:item, :image, seller_id: user.id)
        get :edit, params: {id: item.id}
        expect(response).to render_template :edit
      end
    end
  end
end



