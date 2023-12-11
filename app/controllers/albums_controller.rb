class AlbumsController < ApplicationController

    def index
        @album = Album.all
    end

    def show
        @album = Album.find(params[:id])
    end

    def create
        @album = Album.create(:title, :description)
    end
    

end
