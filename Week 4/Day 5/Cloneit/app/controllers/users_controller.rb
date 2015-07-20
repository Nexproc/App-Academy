class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to user_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    if current_user
      redirect_to user_url
    else
      @user = User.new
      render :new
    end
  end

end
