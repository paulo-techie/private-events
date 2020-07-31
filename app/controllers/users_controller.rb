class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(name: params[:name])
  end

  def show
    # @user.find(prams[:id])
  end
end
