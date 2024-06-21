class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Fetch the IDs of users the current user is following
    following_ids = current_user.followees.pluck(:id)

    # Fetch posts from followed users excluding the current user's own posts
    @followed_users_posts = Post.where(user_id: following_ids).order(created_at: :desc)

    # Fetch posts created by the current user
    @created_posts = current_user.posts.order(created_at: :desc)

    # Fetch posts liked by the current user
    @liked_posts = Post.joins(:likes).where(likes: { user_id: current_user.id }).order('likes.created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: 'Post was successfully destroyed.'
    else
      redirect_to @post, alert: 'You are not authorized to delete this post.'
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
