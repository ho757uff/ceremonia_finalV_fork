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

        if @album.update(album_params)
            album_params[:images].each do |image|
                @album.images.attach(image)
            end    
            redirect_to event_album_path(@event, @album), notice: 'Album was successfully updated.'
        else
            render :edit
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
        params.require(:album).permit(:title, :description, images: [])
    end

