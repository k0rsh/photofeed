# no doccomment
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
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

  def owned_post
    # some kinda guard clause
    return if current_user == @post.user

    flash[:alert] = "This is not your post!"
    redirect_to root_path
  end
end
