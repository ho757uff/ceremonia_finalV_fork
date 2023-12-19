class ImagesController < ApplicationController
    
#une image est rattaché à un album, qui est lui-même attaché à un event
#on les appels en before_action

    before_action :authenticate_user!
    before_action :set_event_and_album                                   #permet de filtrerl'événement et l'album associés à une image
    before_action :authorize_organizer, only: [:destroy]                 #seul l'organisateur peut supprimer des photos
    before_action :authorize_event_access                                #permet de vérifier
    
    
    def index
      @images = @album.images
    end
  
    def show
      @image = @album.images.find(params[:id])
      @attached_image = @image.image
      @comments = @image.comments
      @comment = Comment.new
    end
  
    def new
      @image = @album.images.build
    end
  
    def create
      @image = @album.images.build(image_params)
      @image.user = current_user
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

    def authorize_event_access
      @event = Event.find(params[:event_id])
      @album = Album.find(params[:album_id])
      user_event = current_user.user_events.find_by(event_id: @event.id)
  
      unless user_event
        redirect_to '/'
      end
    end


    def authorize_organizer
      @event = Event.find(params[:event_id])

      unless current_user && current_user.organizer?
          redirect_to '/'
      end

      
  end

  end
  # http://127.0.0.1:3000/events/3/albums/3/images/7