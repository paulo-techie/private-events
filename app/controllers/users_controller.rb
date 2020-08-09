class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name], email: params[:email])

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = ['Sucessfully Signed Up']
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    return if @user.created_events.nil?

    @created_events = @user.created_events
    @prev_events = current_user.previous_events
    @upcoming_events = current_user.upcoming_events
  end
end
