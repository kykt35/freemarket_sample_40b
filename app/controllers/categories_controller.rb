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
        @has_brand = m_category.has_brand
      }
    end
  end
end
