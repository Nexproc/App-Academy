class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :current_token

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= current_token.user
  end

  def current_token
    return nil if session[:session_token].nil?
    @current_token ||= SessionToken.find_by_value(session[:session_token])
  end

  def login(user)
    token = SessionToken.new_token(user)
    token.save!
    session[:session_token] = token.value
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
