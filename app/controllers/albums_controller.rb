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
      
          # Vérifier si l'utilisateur actuel a le rôle d'organisateur (role_id spécifique, par exemple 1) pour l'événement OU
          # s'il est l'organisateur de l'album
          redirect_to '/' unless current_user && (is_organizer?(current_user, @event) || current_user.id == @album.user_id)
        else
          # Vérifier si l'utilisateur actuel a le rôle d'organisateur (role_id spécifique, par exemple 1) pour l'événement
          redirect_to '/' unless current_user && is_organizer?(current_user, @event)
        end
      
      rescue ActiveRecord::RecordNotFound
        # Rediriger vers la page d'accueil si l'événement n'est pas trouvé
        redirect_to '/'
      end
      
      private
      
      def is_organizer?(user, event)
        user_event = UserEvent.find_by(user: user, event: event)
        user_event&.role_id == 1 # Assurez-vous que 1 correspond au role_id d'organisateur dans votre application
      end    

end

