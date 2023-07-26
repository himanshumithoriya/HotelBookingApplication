class LocationsController < ApiController
	skip_before_action :authenticate_request
	skip_before_action :check_customer
	skip_before_action :check_owner
	before_action :set_params, only: [:show]
	
	def index
		locations = Location.all
		render json: locations, status: :ok
	end

	def show
		if @location
			render json: @location, status: :ok
		end
	end

	private

	def set_params
		@location = Location.find(params[:id])
	rescue
		render json: { error: "ID not found"}
	end
end
