class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
  before_action :set_post, only: [:destroy, :update, :edit, :show]
  before_action :correct_user, only: [:edit]

  def index
    @posts = Post.all.includes_user.sorted_desc
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "登録しました"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "削除しました"
    redirect_to root_path
  end

  def update
    if @post.update(post_params)
       flash[:notice] = "編集しました"
       redirect_to post_path
    else
      render :edit
    end
  end

  def edit
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    set_post
    if current_user.id = @post.user.id
      flash[:notice] = "権限はありません"
      redirect_to root_path
    end
  end
end
