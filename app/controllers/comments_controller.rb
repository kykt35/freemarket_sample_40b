class CommentsController < ApplicationController
  def create
    @comment = Comment.create(text: comment_params[:text],item_id: comment_params[:item_id],user_id: current_user.id)
    redirect_to @comment.item
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
end
