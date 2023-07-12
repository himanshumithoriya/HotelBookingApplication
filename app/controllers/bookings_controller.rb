class BookingsController < ApplicationController
	skip_before_action :owner_authenticate_request
	before_action :customer_authenticate_request

	

def create
	byebug
	hotel = Hotell.find_by(id: params[:bookings][:hotell_id])
	member = params[:bookings][:member]
	required_rooms = (member/2) + (member%2)
	avl_rooms = hotel.rooms.where(status: "available").where(room_category: params[:bookings][:room_type]).length
	if avl_rooms < required_rooms
		render json: {message: "Rooms not available"}
	else
		rooms = hotel.rooms.where(status: "available").where(room_category: params[:bookings][:room_type]).limit(required_rooms)
		rooms.each do |room|
			@booking = @current_customer.bookings.new(booking_params)
			@booking.room_id=room.id
			(member > 1)? @booking.member = 2 : @booking.member = 1
			member -= 2
			if @booking.save
				room.update(status: "unavailable")		
			end
		end
		render json: {message: "Room Booked!!!"}
	end 
end
	
private
	def booking_params
		
		params.require(:bookings).permit(:customer_name, :mobile_no, :room_type, :member)
	end
end
