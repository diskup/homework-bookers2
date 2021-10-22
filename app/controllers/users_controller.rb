class UsersController < ApplicationController
  before_action :authenticate_user!,except: [:top]
  before_action :ensure_current_user, {only: [:edit, :update]}
  
  def ensure_current_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) if @user != current_user
  end
  
  def index
    @user = current_user
    @users = User.page(params[:page])
    @books = @user.books.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user.id)
       flash[:notice] = "You have updated user successfully."
    else
       render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
  
private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end