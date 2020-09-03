class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    post = Post.find(params[:post_id])
    current_user.likes.create(post_id: post.id)
  end

  def destroy
      post = Post.find(params[:post_id])
      current_user.likes.find_by(post_id: post.id).delete
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

end
