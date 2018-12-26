class CommentsController < ApplicationController
  before_action :set_group
  def create
    @comment = @item.comments.new(comment_params)
    if @comment.save
      redirect_to @comment.item
    else
      render :create
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy if comment.user_id == current_user.id
    redirect_to item_path(comment.item)
  end

  private
  def comment_params
    params.permit(:text,:item_id).merge(user_id: current_user.id)
  end

  def set_group
    @item = Item.find(params[:item_id])
  end
end
