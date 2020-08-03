class SessionsController < ApplicationController

  def new
    render 'new'
  end

  def create
    @user = User.find_by_id(params[:id])
    if @user
      session[:user_id] = @user.id
      # redirect_to user_path(@user.id)
      redirect_to (@user)
    else
      flash[:login_errors] = ["Wrong login"]
      redirect_to login_path
    end
  end
end
