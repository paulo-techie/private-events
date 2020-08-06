class ApplicationController < ActionController::Base
  before_action :user_signedin, only: [:show]
  helper_method :user_attended_event?
  
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

  def user_attended_event?(user_id, event_id)
    @attended = EventAttendance.find_by(attendee_id: user_id, attended_event_id: event_id)
    @attended ? true : false
  end
end
