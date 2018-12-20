class StaticPagesController < ApplicationController
  def index
    @items = Item.all.reverse_order.limit(4)
  end

end
