class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user



  def login(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!
    if @user
      login(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["Incorrect Credentials"]
      render :new
    end
  end

  def logged_in?
    !!current_user
  end

  def logged_in_action
    if logged_in?
      redirect_to cats_url
    end
  end


end
