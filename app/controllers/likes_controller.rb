class LikesController < ApplicationController
	before_action :find_post, only: [:create, :destroy]
	
	def create
		@post = Post.find(params[:post_id])
		@like = @post.likes.new(user_id: current_user.id)
		@like.save
		redirect_to post_path(@post)
	end
	
	def destroy
		@post = Post.find_by(id: params[:post_id])
		@like = @post.likes.find_by(id: params[:id])
		@like.destroy
	end

end
