class CommentsController < ApplicationController
    
  before_action :set_event_and_album_and_image                                                         #filtre qui permet de définir, l'événement, l'album et l'image associé au

  def create
    @comment = @image.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to event_album_image_path(@event, @album, @image), notice: 'Commentaire ajouté.'
    else
      render 'images/show'           # Afficher à nouveau la page de l'image en cas d'échec de sauvegarde du commentaire.
    end
  end

  def destroy
    @comment = @image.comments.find(params[:id])

    if current_user.organizer?                     # Supprimer le commentaire si l'utilisateur est un organisateur.
      @comment.destroy
      redirect_to event_album_image_path(@event, @album), notice: 'Photo supprimée.'
    else                                                                                   # Gérer le cas où un utilisateur non autorisé essaie de supprimer un commentaire.
    end
  end

  private

  def set_event_and_album_and_image                           # Trouver l'événement, l'album et l'image associés aux paramètres de l'URL.
    @event = Event.find(params[:event_id])
    @album = @event.albums.find(params[:album_id])
    @image = @album.images.find(params[:image_id])
  end

  def comment_params                                      # Autoriser uniquement le paramètre 'content' pour la création du commentaire.
    params.require(:comment).permit(:content)
  end


end
