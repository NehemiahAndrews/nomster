class CommentsController < ApplicationController
  before_action :authenticate_user!

	def create
    
    current_place.comments.create(comment_params.merge(:user => current_user))
    redirect_to place_path(current_place)
	end

  private

  def comment_params
    params.require(:comment).permit(:message,:rating)
  end

  helper_method :current_place
  def current_place
    @current_place ||= Place.find_by_id(params[:place_id])
  end
end

