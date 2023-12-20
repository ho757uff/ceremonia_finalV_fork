class AlbumsController < ApplicationController
    

  before_action :authenticate_user!                         # Assure que l'utilisateur est connecté avant d'accéder à n'importe quelle action.
  before_action :set_event                                  # Configure l'événement pour les actions concernées.
  before_action :authorize_event_access                     # Vérifie si l'utilisateur a accès à l'événement.

  def index
    @albums = @event.albums
  end

  def new
    @album = @event.albums.new
  end

  def show
    @album = @event.albums.find(params[:id])
    user_event = current_user.user_events.find_by(event_id: @event.id)

    if user_event
      @images = @album.images          # Si l'utilisateur a accès à l'événement, récupère les images de l'album.
    else
      redirect_to '/', alert: "Vous n'êtes pas autorisé à accéder à cet album."
    end
  end

  def create
    if current_user.organizer?
      @album = @event.albums.create(album_params)
      if @album.save
        redirect_to event_album_images_path(@event, @album)     # Redirige vers la page pour ajouter des images à l'album.
      else
        render 'new'      # Affiche à nouveau le formulaire de création en cas d'échec de sauvegarde de l'album.
      end
    else
      redirect_to '/', alert: "Vous n'êtes pas autorisé à créer un album."
    end
  end

  def update
    @album = Album.find(params[:id])                 
    new_images = params[:album][:images]

    @album.images.attach(new_images) if new_images.present?

    redirect_to event_album_path(@event, @album)        
  end

  def destroy
    @album = @event.albums.find(params[:id])
    if current_user.organizer?
      @album.destroy
      redirect_to event_albums_path(@event)
    else
      redirect_to '/', alert: "Vous n'êtes pas autorisé à supprimer cet album."
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])               # Configure l'événement basé sur l'ID de l'URL.
  end

  def album_params
    params.require(:album).permit(:title, :description, images: [])      # Définit les paramètres acceptés pour la création/modification d'un album.
  end

  def authorize_event_access
    @event = Event.find(params[:event_id])                                 # Vérifie si l'utilisateur a accès à l'événement, sinon redirige vers la page d'accueil.
    user_event = current_user.user_events.find_by(event_id: @event.id)

    unless user_event
      redirect_to '/'
    end
  end

end

