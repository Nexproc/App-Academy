class UsersController < ApplicationController
  def new
    user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      log_in!(user)
    else
      flash[:errors] = user.errors.full_messages
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
