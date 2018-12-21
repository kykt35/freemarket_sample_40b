class CategoriesController < ApplicationController
  def index
    @categories = Category.children_of(Category.find(params[:id]))

  end
end
