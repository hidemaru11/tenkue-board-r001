class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
  before_action :correct_user, only: [:edit]
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find_by(id: params[:comment][:post_id])
    if @comment.save
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "コメントを(140文字以内で)入力してください。"
      render "posts/show"
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find_by(post_id: @post.id, id: params[:id])
    render "posts/show"
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @post
    else
      flash.now[:alert] = "コメントを(140文字以内で)入力してください。"
      render "posts/show"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @post
  end

 private
  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user_id)
  end

  def correct_user
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if current_user.id != @comment.user_id
      flash[:notice] = "権限はありません"
      redirect_to @post
    end
  end
end
