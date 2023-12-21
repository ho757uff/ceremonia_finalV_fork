class LocationsController < ApplicationController
  before_action :authenticate_user!

  # Affiche la liste des emplacements publics et privés accessibles à l'utilisateur actuel
  def index
    @public_locations = Location.where(privacy_status: :location_public)
    @private_locations = Location.joins(event_locations: { event: :user_events }).where(privacy_status: :location_private, user_events: { user_id: current_user.id })
  end

  #Affiche un emplacement si public ou accessible à l'utilisateur
  def show
    begin
      @location = Location.find(params[:id])
      if @location
        @location.location_public? || (@location.location_private? && current_user_can_access_location?)
      else
        redirect_to locations_path, alert: 'Cette localisation est privée ou inaccessible.'
      end
    rescue ActiveRecord::RecordNotFound => e
      redirect_to '/404'
    end
  end

  # Crée une nouvelle location avec des événements accessibles pour l'utilisateur
  def new
    @location = Location.new
    @location.event_locations.build 
    @events = current_user.user_events.where(role_id: 1).map(&:event)
  Rails.logger.debug "@events: #{@events.inspect}"
  end
    
  # Crée un lieux avec les paramètres fournis
  def create
    @location = Location.new(location_params)
    if @location.date < Date.today
      redirect_to new_location_path, alert: "La date est déjà passée."
      return
    end
    if @location.save
      redirect_to locations_path
    else
      render :new
    end
  end

  # Affiche le formulaire pour modifier un emplacement existant
  def edit
    @location = Location.find(params[:id])
    if @location.location_private? && current_user_can_access_location?
      render :edit
    else
      redirect_to locations_path
    end
  end
  
  def update
    @location = Location.find(params[:id])
    if @location.location_private? && !current_user_can_access_location?
      redirect_to locations_path, alert: 'Cette localisation est privée ou inaccessible.'
    else
      if @location.update(location_params)
        redirect_to locations_path, notice: 'Localisation mise à jour avec succès.'
      else
        render :edit
      end
    end
  end
  
  
  def destroy
    @location = Location.find(params[:id])
    @event_locations = @location.event_locations
    if @location.location_private? && current_user_can_access_location?
      @location.destroy
      @event_locations.destroy_all
      redirect_to locations_path
    else
      redirect_to locations_path
    end
  end
  

  private

  def location_params
    params.require(:location).permit(
      :place, 
      :address,
      event_locations_attributes: [:id, :event_id, :location_id, :date, :description]
    )
  end

  def current_user_can_access_location?
    current_user.user_events.exists?(role_id: 1, event_id: @location.events.pluck(:id))
  end
end