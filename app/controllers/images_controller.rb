class ImagesController < ApplicationController

    def index
        @event = Event.find(params[:event_id])
        @album = Album.find(params[:album_id])
        @images = @album.images
    end
    
end
