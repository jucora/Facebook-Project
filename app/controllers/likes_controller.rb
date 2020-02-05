class LikesController < ApplicationController
	before_action :find_post, only: [:create, :destroy]

	def create
		@post.likes.create(user_id: current_user.id) if !like_exists?
		redirect_to post_path(@post)
	end

	def destroy
		if like_exists?
			@like = @post.likes.find(params[:id])
			@like.destroy
		end
		redirect_to post_path(@post)
	end

	private

	def find_post
		@post = Post.find(params[:post_id])
	end

	def like_exists?
		Like.where(user_id: current_user.id, post_id: params[:post_id]).any?
	end
end
