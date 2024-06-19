class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    puts params.inspect
    @comment = @post.comments.build(comment_params)
    @comment.commenter = current_user

    if @comment.save
      redirect_to @post, notice: "Your comment was posted!"
    else
      puts @comment.errors.full_messages if @comment.errors.any?
      flash.now[:danger] = "Your comment wasn't posted!"
      render 'posts/show'
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      redirect_to @post, notice: "Comment was successfully deleted."
    else
      redirect_to @post, alert: "Comment could not be deleted."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body, :commenter, :post_id, :user_id)
  end
end
