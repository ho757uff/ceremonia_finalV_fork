class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
  end
  def show
    @event = Event.find(params[:id])
    if current_user.organizer?
      @guest_users = User.joins(:user_events).where(user_events: { role_id: 2, event_id: @event.id })
      render :show
    end
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
      # Gérer l'échec de la création de l'événement
    end
  end
  

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_show_path(@event), notice: 'Événement mis à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
  end

  private

  private
  
  def event_params
    params.require(:event).permit(:title, :program, :date, :city_name)
  end
  def organizer?
    roles.exists?(role_name: 'organizer')
  end

  def guest
  end
end
