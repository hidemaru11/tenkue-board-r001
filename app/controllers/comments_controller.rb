class CommentsController < ApplicationController

 def new
   @comment = Comment.new
 end

 def create
   @comment = Comment.create(comment_params)
   @post = Post.find_by(id: params[:comment][:post_id])
   if @comment.save
     redirect_to "/posts/#{@post.id}"
   else
     flash[:alert] = "コメントを(140文字以内で)入力してください。"
     redirect_to @post
   end
 end

 private
 def comment_params
   params.require(:comment).permit(:comment, :post_id, :user_id)
 end
end
