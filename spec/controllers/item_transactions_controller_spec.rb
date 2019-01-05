require 'rails_helper'

describe ItemTransactionsController, type: :controller do
    let(:user) { create(:user)}
    let(:item) { create(:item) }
    let(:params) {{ item_id: item.id }}
      describe 'GET #new' do
        context 'logged in' do
          before do
            login user
            get :new, params
          end
          it "assigns @item_transaction" do
            expect(assigns(:item_transaction)).to be_a_new(ItemTransaction)
          end
          it 'renders the :new template' do
            expect(response).to render_template :new
          end
          context 'not logged in' do
            before do
              get :new
            end
            it 'redirects to  new_user_session_path' do
              expect(response).to redirect_to(new_user_session_path)
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
      describe 'POST #create' do

        let(:params) do
         { user_id: user.id, item_transaction: attributes_for(:item_transaction) }
       end

       context 'logged in' do
         before do
            login user
          end

          context 'can save' do
            subject{
              post :create,
              params: params
            }
            it 'count up item_transactions' do
              expect{ subject }.to change(ItemTransaction, :count).by(1)
            end
            it "redirects to static_pages#index" do
              post :create, item_transaction: attributes_for(:item_transaction)
              expect(response).to redirect_to root_path
            end
          end

          context 'can not save' do
            let(:invalid_params) do
              { user_id: user.id, item: attributes_for(:item_transaction, name: nil) }
            end

            subject {
              post :create,
              params: invalid_params
            }
            it 'does not count up' do
              expect{ subject }.not_to change(ItemTransaction, :count)
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
end
