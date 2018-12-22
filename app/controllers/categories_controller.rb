class CategoriesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json{
         @categories = Category.children_of(Category.find(params[:id]))
      }
    end
  end
  def size_brand
    respond_to do |format|
      format.html
      format.json{
        m_category = Category.find(params[:id]).parent
        @sizes = m_category.sizes
        @hasBrand = m_category.hasrand
      }
    end
  end
end
