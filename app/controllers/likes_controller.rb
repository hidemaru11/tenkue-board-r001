class LikesController < ApplicationController
  before_action :set_post
  before_action :log_in_user?

  def create
    current_user.likes.create(post_id: @post.id)
  end

  def destroy
    like = current_user.likes.find_by(id:params[:id])
    like.delete
  end

  private

    # 押したいいねボタンを所有している投稿のidを取得
    def set_post
      @post = Post.find(params[:post_id])
    end

    def log_in_user?
      unless user_signed_in?
        flash[:alert] = "新規登録もしくはユーザーログインを行ってください"
        redirect_to new_user_session_path
      end
    end

end
