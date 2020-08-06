class ApplicationController < ActionController::Base
  before_action :user_signedin, only: [:show]

  private

  def user_signedin
    if session[:user_id].nil?
      flash[:errors] = ["You must signin to gain user access"]
      redirect_to login_path
    end
  end

  def current_user
    @user = User.find_by_id(session[:user_id]) unless session[:user_id].nil?
  end
end
