class PlacesController < ApplicationController
	before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
	before_filter :require_selected_place, :only => [:show, :edit, :update, :destroy]

	def index
		@places = Place.paginate(:page => params[:page], :per_page => 10)
	end

	def new
		@place = Place.new
	end

	def create
		@place = current_user.places.create(place_params)
		if @place.valid?
			redirect_to root_path
		else
			render :new, :status => :unprocessable_entity
		end
	end

	def show
		@comment = Comment.new
		@photo = Photo.new
	end

	def edit
		if selected_place.user != current_user
			return render :text => 'Not Allowed', :status => :forbidden
		end
	end

	def update
		if selected_place.user != current_user
			return render :text => 'Not Allowed', :status => :forbidden
		end

		selected_place.update_attributes(place_params)
		if selected_place.valid?
			redirect_to root_path
		else
			render :edit, :status => :unprocessable_entity
		end
	end

	def destroy
		if selected_place.user != current_user
			return render :text => 'Not Allowed', :status => :forbidden
		end

		selected_place.destroy
		redirect_to root_path
	end

	private

	def place_params
		params.require(:place).permit(:name, :description, :address)
	end

	helper_method :selected_place
  def selected_place 
    @selected_place ||=Place.find_by_id(params[:id])
  end

  def require_selected_place
    render_not_found unless selected_place
  end
end
