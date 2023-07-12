class HotellsController < ApplicationController
  before_action :owner_authenticate_request
	skip_before_action :customer_authenticate_request
	 
 	def index
 		@hotel = @current_owner.hotells
		render json: @hotel
 	end

 	def show
 		@hotel = @current_owner.hotells.find(params[:id])
 		unless @hotel.nil?
 			render json: @hotel
	 	end
	 	rescue
	 		render json: {message: "Hotel not found"}
 	end

	def create
		@hotel = @current_owner.hotells.new(hotel_params)
		@hotel.image.attach(params[:image])
	  if @hotel.save
      render json: @hotel, status: :created
    else
      render json: {error: "Hotel not build"}
    end
	end

		
	def my_hotels
		@hotel = @current_owner.hotells
		unless @hotel.empty?
			render json: @hotel
		else
			render json: {error: "Hotel Closed"}
		end
	end


	def search_hotel
		location = Location.find_by(name: params[:name])
		@hotel = @current_owner.hotells.find_by(location_id: location.id)
		unless @hotel.nil?
			render json: @hotel
		else
			render json: {message: "Hotel Couldn't found"}
		end
	end

	def search_hotel_by_name
		unless params[:name].strip.empty?
			@hotel = @current_owner.hotells.where("name like ?", "%"+params[:name].strip+"%")
			unless @hotel.empty?
				render json: @hotel
			else
				render json: {message: "Couldn't find hotel with this name"}
			end
		else
			render json: {message: "field can't be blank"}
		end
		rescue
			render json: {message: "Please pass parameter"}
	end
	

	def see_hotel_with_room
    unless params[:name].strip.empty?
      @hotel_with_room = Hotell.where("name like ?", "%"+params[:name].strip+"%")
      @hotel_with_room = @hotel_with_room.to_a
      unless @hotel_with_room.empty?
        @ids = @hotel_with_room[0][:id]
        @hotel = Hotell.find(@ids)
        @hotel = @hotel.rooms
        render json: @hotel 
      else
        render json: {message: "Hotel Not found"}
      end
    else
      render json: {message: "field can't be blank"}
    end
    rescue  
      render json: {message: "please pass paramater"}
  end
  

	private
		def hotel_params
			params.permit(:name, :address, :contact, :status, :location_id, :image)
		end

end
