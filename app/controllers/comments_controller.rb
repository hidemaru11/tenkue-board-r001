class CommentsController < ApplicationController

 def new
   @comment = Comment.new
 end

 def create
   @comment = Comment.new(comment_params)
   @post = Post.find_by(id: params[:comment][:post_id])
   if @comment.save
     redirect_to post_path(@post)
   else
     flash[:alert] = "コメントを(140文字以内で)入力してください。"
     render "posts/show"
   end
 end

 def edit
  @post = Post.find(params[:post_id])
  @comment = Comment.find_by(post_id: @post.id, id: params[:id])
 end

 def update
  @post = Post.find(params[:post_id])
  @comment = Comment.find(params[:id])
  if @comment.update(comment_params)
    redirect_to @post
  else
    render 'layouts/comment_form'
  end
 end

 private
 def comment_params
   params.require(:comment).permit(:comment, :post_id, :user_id)
 end
end
