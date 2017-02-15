class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :show]
  before_action :owned_profile, only: [:edit, :update]

  def edit
  end

  def update
    if @user.update(profile_params)
      flash[:success] = "Your profile has been updated!"
      redirect_to profile_path(@user.user_name)
    else
      flash[:error] = "Ooops! Something is wrong!"
      redirect_to :edit
    end
  end

  def show
    @posts = @user.posts.order('created_at DESC')
  end

  private

  def profile_params
    params.require(:user).permit(:bio, :avatar)
  end

  def set_user
    @user = User.find_by(user_name: params[:user_name])
  end

  def owned_profile
    # some kinda guard clause
    return if current_user == @user

    flash[:alert] = "This is not your profile!"
    redirect_to profile_path(@user.user_name)
  end
end
