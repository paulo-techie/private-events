class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :user_signedin, only: %i[new create]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @past = Event.past
    @upcoming = Event.upcoming
  end

  # GET /events/1
  # GET /events/1.json
  def show; end

  # GET /events/new
  def new
    @event = current_user.created_events.build
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event
      flash[:success] = ['Event was successfully created']
    else
      render :new
    end
  end

  def attend
    user_id = session[:user_id]
    event_id = params[:id]

    if user_id.nil?
      flash[:errors] = ['You need to login to attend this event']
      redirect_to event_path(event_id)
    elsif user_attended_event?(user_id, event_id)
      flash[:errors] = ['Well, you are already attending this event']
      redirect_to event_path(event_id)
    else
      @attendance = EventAttendance.create(attendee_id: user_id, attended_event_id: event_id)
      redirect_to events_path
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
end
