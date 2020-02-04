class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			redirect_to @post
		else
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
