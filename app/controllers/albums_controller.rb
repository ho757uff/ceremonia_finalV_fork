class AlbumsController < ApplicationController

    def index
        @event = Event.find(params[:event_id])
        @albums = @event.albums
    end

    def new
        @event = Event.find(params[:event_id])
        @album = Album.new
    end

    def show
        @album = Album.find(params[:id])
    end

    def create
        @event = Event.find(params[:event_id])  # Assurez-vous de récupérer l'événement correctement
        @album = @event.albums.create(album_params)

        if @album.save
            redirect_to event_album_images_path(@event, @album)
        else
            render 'new'
        end

    end

    def destroy
        @event = Event.find(params[:event_id])
        @album = @event.albums.find(params[:id])
        @album.destroy
        redirect_to event_path(@event)
    end
    

    def event_album
        @event = Event.find(params[:event_id])
        @album = @event.albums.first

        if @album.nil?
            redirect_to new_event_album_path(event_id: @event)
        else
            redirect_to event_albums_path(event_id: @event)
        end

    end

end

private

    def album_params
        params.require(:album).permit(:title, :description)
    end

