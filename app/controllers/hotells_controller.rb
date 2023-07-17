class HotellsController < ApiController
	skip_before_action :customer_authenticate_request
	before_action :set_params, only: [:show, :destroy]
	 
 	def index
		hotels =	if params[:location].present?
			 			 		search_hotel_by_location()
					  	elsif params[:name].present?
								search_hotel_by_name()
							else
								hotels = Hotell.all
							end 
	  render json: hotels 
 	end

 	def show
 		hotel = @current_owner.hotells
 		return unless hotel.present?
		render json: hotel
 	end

	def create
		hotel = @current_owner.hotells.new(hotel_params)
	  if hotel.save
      render json: hotel, status: :created
    else
      render json: { error: hotel.errors.full_messages }, status: :unprocessable_entity
    end
	end
		
	def destroy
		if @hotel
			@hotel.destroy
			render json: { message: "Hotel Deleted !!!" }, status: :ok
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

		def search_hotel_by_location
		  hotels = Hotell.joins(:location).where('locations.name like ?', "%#{params[:location]}%")
		end
end