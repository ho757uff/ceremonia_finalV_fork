class ImagesController < ApplicationController
    
#une image est rattaché à un album, qui est lui-même attaché à un event
#on les appels en before_action

    before_action :set_event_and_album 
    
    
    def index
      @images = @album.images
    end
  
    def show
      @image = @album.images.find(params[:id])
      @attached_image = @image.image
    end
  
    def new
      @image = @album.images.build
    end
  
    def create
      @image = @album.images.build(image_params)
      if @image.save
        redirect_to event_album_images_path(@event, @album)
      else
        render :new
      end
    end
  
    def edit
      @image = @album.images.find(params[:id])
    end
  
    def update
      @image = @album.images.find(params[:id])
      if @image.update(image_params)
        redirect_to event_album_images_path(@event, @album)
        render :edit
      end
    end
  
    def destroy
      @image = @album.images.find(params[:id])
      @image.destroy
      redirect_to event_album_images_path(@event, @album)
    end
  


    private
  
    def set_event_and_album                          #les appels de event et d'album pour l'accès à la route de l'image
      @event = Event.find(params[:event_id])
      @album = @event.albums.find(params[:album_id])
    end
  
    def image_params
      params.require(:image).permit(:title, :description, :image)
    end
  end
  