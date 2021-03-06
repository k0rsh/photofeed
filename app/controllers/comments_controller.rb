class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = @post.comments.order("created_at ASC")

    respond_to do |format|
      format.html { render layout: !request.xhr? }
    end
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      # flash[:success] = "Your comment has been added!"
      # redirect_to :back
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:alert] = "Oops! Something went completly wrong!"
      redirect_to root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    # kinda guard clause (rubocop forever)
    # return if @comment.user_id != current_user.id
    return unless @comment.user_id == current_user.id

    @comment.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
