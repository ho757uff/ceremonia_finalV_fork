class CommentsController < ApplicationController
    
  before_action :set_event_and_album_and_image                                                         #filtre qui permet de définir, l'événement, l'album et l'image associé au

  def create
    @comment = @image.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to event_album_image_path(@event, @album, @image), notice: 'Commentaire ajouté.'
    else
      render 'images/show'
    end
  end

  def destroy
    @comment = @image.comments.find(params[:id])

    if current_user.organizer?
      @comment.destroy
      redirect_to event_album_image_path(@event, @album), notice: 'Photo supprimée.'
    else
    end
  end

  private

  def set_event_and_album_and_image
    @event = Event.find(params[:event_id])
    @album = @event.albums.find(params[:album_id])
    @image = @album.images.find(params[:image_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end


end
