class StaticPagesController < ApplicationController
  def index
    @items = Item.with_attached_images.reverse_order.limit(4)
  end

end
