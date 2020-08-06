class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :user_signedin, only: [:new, :create]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @past = Event.past
    @upcoming = Event.upcoming
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = current_user.created_events.build
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.created_events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, success: 'Event was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end


  def attend
    user_id = session[:user_id]
    event_id = params[:id]
    
    unless user_id.nil?
      unless user_attended_event?(user_id, event_id)
        @attendance = EventAttendance.create(attendee_id: user_id, attended_event_id: event_id)
        redirect_to event_path(event_id)
      else
        flash[:errors] = ["Well, you are already attending this event"]
        redirect_to event_path(event_id)
      end
    else
      flash[:errors] = ["You need to login to attend this event"]
      redirect_to event_path(event_id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :time, :description)
    end

    def user_attended_event?(user_id, event_id)
      @attended = EventAttendance.find_by(attendee_id: user_id, attended_event_id: event_id)
      @attended ? true : false
    end
end
