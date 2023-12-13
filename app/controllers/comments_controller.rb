class CommentsController < ApplicationController
    
  before_action :set_event_and_album_and_image

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
    @comment.destroy
    redirect_to event_album_image_path(@event, @album, @image), notice: 'Commentaire supprimé.'
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
