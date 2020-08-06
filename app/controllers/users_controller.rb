class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name], email: params[:email])

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = ["Sucessfully Signed Up"]
      redirect_to (@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    unless @user.created_events.nil?
      @prev_events = current_user.previous_events
      @upcoming_events = current_user.upcoming_events
    end
  end
end
