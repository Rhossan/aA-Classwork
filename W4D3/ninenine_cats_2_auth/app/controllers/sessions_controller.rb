class SessionsController < ApplicationController

  before_action :logged_in_action, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    debugger
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if @user
      login(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["Incorrect Credentials"]
    end

  end

  def destory
    @current_user.reset_session_token! if !!@current_user
    session[:session_token] = nil
    redirect_to new_session_url
  end

  # logout
  #    redirect_to new_session_url
  # private
  #
  # def params

end
