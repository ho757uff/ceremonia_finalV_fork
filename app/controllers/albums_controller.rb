class AlbumsController < ApplicationController

    # un album est attaché à un event, cf: routes, il est nécessaire d'appeler l'event à chaque action
    before_action :authenticate_user!
    before_action :authorize_organizer

    def index
        @event = Event.find(params[:event_id])
        @albums = @event.albums
    end

    def new
        @event = Event.find(params[:event_id])
        @album = @event.albums.new
    end

    def show
        @event = Event.find(params[:event_id])
        @album = Album.find(params[:id])
        @images = @album.images
    end

    def create
        @event = Event.find(params[:event_id])
        @album = @event.albums.create(album_params)

        if @album.save
            redirect_to event_album_images_path(@event, @album)
        else
            render 'new'
        end

    end

    def update
        @event = Event.find(params[:event_id])
        @album = Album.find(params[:id])
        new_images = params[:album][:images]

        @album.images.attach(new_images) if new_images.present?

        redirect_to event_album_path(@event, @album)        
    end

    def destroy
        @event = Event.find(params[:event_id])
        @album = @event.albums.find(params[:id])
        @album.destroy
        redirect_to event_albums_path(@event)
    end




private

    def album_params
        params.require(:album).permit(:title, :description, images: [])
    end

    def authorize_organizer
        @event = Event.find(params[:event_id])
    
        if params[:id].present?
          @album = Album.find(params[:id])
    
          unless current_user && (current_user == @event.organizer || current_user.organizer?)
            redirect_to '/'
          end

        else
          redirect_to '/'

        end
      rescue ActiveRecord::RecordNotFound
        redirect_to '/'
      end
   


end

