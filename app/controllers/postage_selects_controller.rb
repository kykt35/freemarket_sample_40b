class PostageSelectsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json{
         @shippings = PostageSelect.find(params[:id]).shippings
      }
    end
  end
end

