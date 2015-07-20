class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user.nil?
      flash.now[:errors] ||= []
      flash.now[:errors]  << "Invalid username or password."
      render :new
    else
      login(@user)
      redirect_to :user
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

  def logout
    self.current_token.destroy!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
