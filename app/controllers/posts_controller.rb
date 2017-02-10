# no doccomment
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    if @post = Post.create(post_params)
      flash[:success] = "Your post has been created!"
      redirect_to root_path
    else
      flash.now[:alert] = "Can't create! Check your input!"
      render :new
    end
  end

  def show
    # @post is set via :before_action
  end

  def edit
    # @post is set via :before_action
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated!"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "Update failed!"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
