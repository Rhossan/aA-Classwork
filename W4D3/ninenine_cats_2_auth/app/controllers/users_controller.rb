class UsersController < ApplicationController
  before_action :logged_in_action, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    debugger
    @user = User.new(user_params)
    @user.save

    if @user.save
      redirect_to cats_url
      login(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
    # login_user!

  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
