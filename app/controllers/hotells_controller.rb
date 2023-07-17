class HotellsController < ApiController
	skip_before_action :customer_authenticate_request
	before_action :set_params, only: [:show, :destroy]
	 
 	def index
 		if
 			location = Location.where("name like ?","%#{params[:name]}%").first
		  return render json: { message: "Location not found" } unless location.present?
		  hotels = @current_owner.hotells.where("location_id = ? OR location_id in (
 			 select id from locations where name like ?)", location.id, "%#{params[:name]}%")
			return render json: { message: "Hotels couldn't be found" } unless hotels.present?
		  render json: hotels
		else
			if 
				hotel_by_name()
			else
		 		hotels = @current_owner.hotells
				render json: hotels
			end
		end
 	end

 	def show
 		hotel = @current_owner.hotells
 		return  unless hotel.present?
		render json: hotel
 	end

	def create
		hotel = @current_owner.hotells.new(hotel_params)
	  if hotel.save
      render json: hotel, status: :created
    else
      render json: { error: hotel.errors.full_messages }
    end
	end
		
	def search_hotel_by_location
	  location = Location.where("name like ?","%#{params[:name]}%").first
	  return render json: { message: "Location not found" } unless location.present?
	  hotel = @current_owner.hotells.where(location_id: location.id)
	  return render json: { message: "Hotel couldn't be found" } unless hotel.present?
	  render json: hotel
	end

	def search_hotel_by_name
		hotel_by_name()
	end

	def destroy
		if @hotel
			@hotel.destroy
			render json: { message: "Hotel Deleted !!!" }
		end
	end
	
 	private

		def hotel_params
			params.permit(:name, :address, :contact, :status, :location_id, :image)
		end

		def set_params
			@hotel = @current_owner.hotells.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			render json: {message: "Id not found"}	
		end
end
