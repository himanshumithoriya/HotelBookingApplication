class LocationsController < ApiController
	skip_before_action :owner_authenticate_request
	skip_before_action :customer_authenticate_request
	before_action :set_params, only: [:show]
	
	def index
		locations = Location.all
		render json: locations
	end

	def show
		if @location
			render json: @location
		end
	end

	private

	def set_params
		@location = Location.find(params[:id])
	rescue
		render json: { error: "ID not found"}
	end
end
