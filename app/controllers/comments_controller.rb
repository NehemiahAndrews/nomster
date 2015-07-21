class CommentsController < ApplicationController
  before_action :authenticate_user!

	def create
    @comment = selected_place.comments.create(comment_params.merge(:user => current_user))
      if @comment.valid?
        redirect_to place_path(selected_place)
      else 
        return render :text => 'Invalid', :status => :unprocessable_entity
      end
	end

  private

  def comment_params
    params.require(:comment).permit(:message,:rating)
  end

  helper_method :selected_place
  def selected_place
    @selected_place ||= Place.find_by_id(params[:place_id])
  end
end

