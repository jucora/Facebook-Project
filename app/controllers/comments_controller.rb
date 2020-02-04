class CommentsController < ApplicationController
	before_action :find_post, only: %i[create edit]

	def create
		@comment = @post.comments.create(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			flash[:notice] = 'Comment created!'
			redirect_to @post
		else
			flash[:alert] = 'Something went wrong'
			redirect_to @post
		end
	end

	def edit
		@comment = @post.comments.find_by(id: params[:id])
	end

	def update
		@post = Post.find_by(id: params[:comment][:post_id])
		@comment = @post.comments.find_by(id: params[:id])
		if @comment.update_attributes(comment_params)
			flash[:notice] = 'Comment updated!'
      redirect_to @post
		else
			flash[:alert] = 'Something went wrong'
      render 'edit'
		end
	end

	def destroy
		@comment = Comment.find_by(id: params[:id])
		@comment.destroy
		redirect_back(fallback_location: root_path)
	end

	private

	def comment_params
		params.require(:comment).permit(:body, :post_id)
	end

	def find_post
		@post = Post.find_by(id: params[:post_id])
	end
end
