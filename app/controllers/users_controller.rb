class UsersController < ApplicationController
  def new
    @user = User.new(flash[:user])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render :show
    else
      flash.now[:error_messages] = @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show

  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :password)
  end

end
