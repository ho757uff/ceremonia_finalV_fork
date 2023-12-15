class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, except: [:index, :new, :create]
  before_action :require_organizer, only: [:edit, :update, :destroy, :add_location, :create_association, :destroy_association, :guest_list, :remove_guest]
  def index
    @events = Event.joins(:user_events).where(user_events: { user_id: current_user.id, role_id: 1 })
  end

  def show
    @guest_users = User.guests(@event)
    @event_locations = @event.event_locations
    render :event_details_only unless @event.organizer?(current_user)
  end
  
  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      current_user.user_events.create(event_id: @event.id, role_id: 1, user_id: current_user.id)
      redirect_to @event
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end
  
  def destroy
    @event.destroy
  end
  
  def add_location
    @public_locations = Location.where(privacy_status: :location_public)
    @private_locations = Location.joins(event_locations: { event: :user_events }).where(privacy_status: :location_private, user_events: { user_id: current_user.id })
  end
  
  def create_association
    locations_params = params[:event_location]
    if locations_params.present?
      locations_params.each do |location_id, location_params|
        permitted_params = event_location_params(location_params)
        EventLocation.create(permitted_params.merge(event_id: @event.id, location_id: location_id)) if params[:location_ids].include?(location_id)
      end
      redirect_to @event, notice: 'Locations were successfully added to the event.'
    else
      redirect_to @event, alert: 'No locations were selected to be added.'
    end
  end

  def destroy_association
    @event_location = EventLocation.find(params[:id])
    @event_location.destroy
    redirect_to @event, notice: 'Location was successfully removed from the event.'
  end

  def guest_list
    @guests = User.guests(@event)
  end

  def add_guest
    @role = Role.find_by(role_name: 'guest') 
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: 'password123', password_confirmation: 'password123')
    if @user.save
      UserEvent.create(user: @user, event: @event, role: @role)
      redirect_to guest_list_event_path(@event), notice: 'Guest was successfully added.'
    else
      render :guest_list
    end
  end
  
  def remove_guest
    @user = User.find(params[:user_id])
    user_event = UserEvent.find_by(user: @user, event: @event, role: Role.find_by(role_name: 'guest'))
    user_event.destroy if user_event
    redirect_to @event, notice: 'Guest was successfully removed.'
  end

  def join_as_guest
    @event.user_events.create(user_id: current_user.id, role_id: 2)
    redirect_to @event
  end
  

  private
  
  def event_params
    params.require(:event).permit(:title, :date, :city_name, :program, :description)
  end

  def set_event
    begin
      @event = Event.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to '/404'
    end
  end

  def require_organizer
    redirect_to @event unless @event.organizer?(current_user)
  end

  def event_location_params(input_params)
    input_params.permit(:location_id, :event_id, :date, :description)
  end
end
