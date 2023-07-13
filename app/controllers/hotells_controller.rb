class HotellsController < ApplicationController
	before_action :owner_authenticate_request
	skip_before_action :customer_authenticate_request
	before_action :set_params, only: [:show]
	 
 	def index
 		@hotels = @current_owner.hotells
		render json: @hotels
 	end

 	def show
 		@hotel = @current_owner
 		return  unless @hotel.present?
		render json: @hotel
 	end

	def create
		@hotel = @current_owner.hotells.new(hotel_params)
	  if @hotel.save
      render json: @hotel, status: :created
    else
      render json: { error: @hotel.errors.full_messages }
    end
	end

		
	def my_hotels
		@hotel = @current_owner.hotells
		return render json: { message: "Hotel not found" } unless @hotel.present? 
		render json: @hotel
	end

	def search_hotel_by_location
	  location = Location.where("name like ?","%#{params[:name]}%").first
	  return render json: { message: "Location not found" } unless location.present?
	  @hotel = @current_owner.hotells.where(location_id: location.id)
	  return render json: { message: "Hotel couldn't be found" } unless @hotel.present?
	  render json: @hotel
	end


	def search_hotel_by_name
		hotel_by_name()
	end
	
 	# def see_hotel_with_room
	#  		hotel_with_room()
	# end

  
	private
		def hotel_params
			params.permit(:name, :address, :contact, :status, :location_id, :image)
		end

		def set_params
			@hotel = Hotell.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			render json: {message: "Id not found"}	
		end
end
