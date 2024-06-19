class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    redirect_to posts_path
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to posts_path
  end
end
