class UsersController < ApplicationController
  def create

    #sign up the user
    @user = User.new(user_params)

    if @user.save
      redirect_to users_url # I am being redirected to create
    else
      @user.errors.full_messages
      render :new
    end
  end

  def new
    #present form for signup
  end

  def show
    @user = User.find(params[:id])
    render :show
    #show the user's details
  end



  def user_params
    params.require(:user).permit(:email,:password,:session_token)
  end

end
