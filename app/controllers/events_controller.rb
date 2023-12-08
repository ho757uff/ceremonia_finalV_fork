class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @all_events = Event.all
    if current_user.organizer?
      @events = @all_events.joins(:user_events).where(user_events: {role_id: 1, user_id: current_user.id})
    end
  end

  def show
    @event = Event.find(params[:id])
    @guest_users = User.joins(:user_events).where(user_events: { role_id: 2, event_id: @event.id })
    @event_locations = @event.event_locations
    unless @event.organizer?(current_user)
      render :event_details_only
    end
  end

  def new
    @event = Event.new
  end

  def add_location
    @event = Event.find(params[:id])
    @locations = Location.all
  end

  def create_association
    @event = Event.find(params[:id])
    locations_params = params[:event_location]

    if locations_params.present?
      locations_params.each do |location_id, location_params|
        permitted_params = event_location_params(location_params)
        if params[:location_ids].include?(location_id)
          EventLocation.create(permitted_params.merge(event_id: @event.id, location_id: location_id))
        end
      end
      redirect_to @event, notice: 'Locations were successfully added to the event.'
    else
      redirect_to @event, alert: 'No locations were selected to be added.'
    end
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      current_user.user_events.create(event_id: @event.id, role_id: 1, user_id: current_user.id)
      redirect_to @event
    else
      # Gérer l'échec de la création de l'événement
    end
  end
  
  def join_as_guest
    @event = Event.find(params[:id])
    current_user.user_events.create(event_id: @event.id, role_id: 2)
    redirect_to @event
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_show_path(@event)
    else
      render :edit
    end
  end

  def destroy
  end


  private
  
  def event_params
    params.require(:event).permit(:title, :program, :date, :city_name)
  end
  def organizer?
    user_events.exists?(role_id: 1, user_id: current_user.id, event_id: params[:id])
  end

  def event_location_params(input_params)
    input_params.permit(:location_id, :event_id, :date, :description)
  end

end
