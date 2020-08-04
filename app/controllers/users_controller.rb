class UsersController < ApplicationController
  before_action :user_signedin, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name], email:params[:email])
    
    if @user.save
      session[:user_id] = @user.id
      flash[:login_success] = ["Sucessfully Signed Up"]
      redirect_to user_path(@user.id)
    else
      flash[:registration_errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @created_events = @user.created_events unless @user.created_events.nil?
  end

  private

  def user_signedin
    if session[:user_id].nil?
      flash[:login_errors] = ["You must signin to access a user's account"]
      redirect_to login_path
    end
  end
end
