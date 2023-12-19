class AlbumsController < ApplicationController
    

  before_action :authenticate_user!
  before_action :set_event
  before_action :authorize_event_access

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
      @images = @album.images
    else
      redirect_to '/', alert: "Vous n'êtes pas autorisé à accéder à cet album."
    end
  end

  def create
    if current_user.organizer?
      @album = @event.albums.create(album_params)
      if @album.save
        redirect_to event_album_images_path(@event, @album)
      else
        render 'new'
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
    @event = Event.find(params[:event_id])
  end

  def album_params
    params.require(:album).permit(:title, :description, images: [])
  end

  def authorize_event_access
    @event = Event.find(params[:event_id])
    user_event = current_user.user_events.find_by(event_id: @event.id)

    unless user_event
      redirect_to '/'
    end
  end

end

