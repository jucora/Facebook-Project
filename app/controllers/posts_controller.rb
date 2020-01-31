class PostsController < ApplicationController
  def index
    @posts = Post.all
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
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
