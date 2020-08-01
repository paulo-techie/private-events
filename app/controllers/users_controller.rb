class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name])

    if @user.save
      redirect_to new_user_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
