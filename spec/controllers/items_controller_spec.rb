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
    let(:params) {{seller_id: user.id, item: attributes_for(:item)}}

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
        let(:invalid_params) {{seller_id: user.id, item: attributes_for(:item, name: nil)}}
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
      it 'redirects to  new_user_session_path' do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe '#show' do
      context 'viewが正常か'  do
        it 'showの画面が表示できているか' do
          item = create(:item,seller_id: user.id,name: "タイトル")
          get :show, params: {id: item.id}
          expect(response).to render_template :show
        end
        it 'タイトルを取得できるか' do
          item = create(:item,seller_id: user.id,name: "タイトル")
          get :show, params: {id: item.id}
          expect(assigns(:item)).to eq item
        end
      end
    end

    describe '#edit' do
      context '@itemの情報が取れている' do
      it 'has a 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns @item' do
        item = create(:item)
        get :edit, params: {id: item.id}
        expect(assigns(:item)).to eq item
      end

      it 'renders the :edit template' do
        item = create(:item)
        get :edit, params: {id: item.id}
        expect(response).to render_template :edit
      end
    end
  end

end







