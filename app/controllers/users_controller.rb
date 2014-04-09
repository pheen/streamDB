class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      session[:user_id] = @user.id
    else
      flash[:error] = @user.errors
    end

    render 'new'
  end

  def login
    @user = User.authenticate(params[:username], [:password])
    if @user
      session[:user_id] = @user.id
    else
      render('streams')
    end
  end

  def logout
    @current_user = nil    
  end
end
