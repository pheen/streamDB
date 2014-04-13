class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login(user)
    session[:user_id] = user.id
    set_current_user
  end

  def user_logged_in?
    session[:user_id].present? && @current_user
  end

  def set_current_user
    @current_user = User.find_by_id(session[:user_id])
    @current_user ||= GuestUser.new(1, 'Guest')
  end

  def logout_user
    @current_user, session[:user_id] = nil, nil
  end

  GuestUser = Struct.new(:id, :username)
end
