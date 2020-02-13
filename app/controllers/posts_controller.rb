class PostsController < ApplicationController
  def index
    @posts = Post.most_recent
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = 'Post created!'
      redirect_to @post
    else
      flash[:alert] = 'Something went wrong'
      render 'new'
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update_attributes(post_params)
      flash[:notice] = 'Post updated!'
      redirect_to @post
    else
      flash[:alert] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = 'Post deleted!'
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
