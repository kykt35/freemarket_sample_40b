class CategoriesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json{
         @categories = Category.children_of(Category.find(params[:id]))
      }
    end
  end
end
