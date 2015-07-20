class SessionsController < ApplicationController
  def new
    user = User.new
  end

  def logout
    current_user.reset_token!
    session[:session_token] = nil
    redirect_to new_user_url
  end


  def create
    user = User.find_by_credentials(
                                    params[:user][:email],
                                    params[:user][:password]
                                    )
    if user
      log_in!(user)
    else
      flash[:errors] = "Incorrect Username/Password"
      render :new
    end
  end
end
