class BookingsController < ApplicationController
	skip_before_action :owner_authenticate_request
	before_action :set_params, only: [:show]

	def create
		hotel = Hotell.find_by(id: params[:bookings][:hotell_id])
		member = params[:bookings][:member]
		required_rooms = (member / 2) + (member % 2)
		avl_rooms = hotel.rooms.where(status: "available").where(room_category: params[:bookings][:room_type]).length
		if avl_rooms < required_rooms
			render json: {message: "Rooms not available"}
		else
			rooms = hotel.rooms.where(status: 'available').where(room_category: params[:bookings][:room_type]).limit(required_rooms)
			rooms.each do |room|
				@booking = @current_customer.bookings.new(booking_params)
				@booking.room_id = room.id
				(member > 1)? @booking.member = 2 : @booking.member = 1
				member -= 2
				if @booking.save
					room.update(status: 'unavailable')		
				end
			end
			render json: { message: 'Room Booked!!!' }
		end 
	end

	def see_bookings
    @bookings = @current_customer.bookings
    return render json: { message: 'No Booking found' } unless @bookings.present?
    render json: @bookings
  end

  def filter_bookings_by_location
    booking =ActiveRecord::Base.connection.execute("select bookings.customer_name, bookings.mobile_no from bookings inner join users on users.id = bookings.user_id inner join rooms on rooms.id = bookings.room_id inner join hotells on hotells.id = rooms.hotell_id inner join locations on locations.id = hotells.location_id where users.id = #{@current_customer.id} and locations.name = '#{params[:name]}'")
    return render json: { message: 'booking not found' } unless booking.present?
    render json: booking
  end

  def show
    return render json: @booking if @booking.present?
  end

	private

		def booking_params
			params.require(:bookings).permit(:customer_name, :mobile_no, :room_type, :member)
		end

		def set_params
			@booking = Booking.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			render json: { message: 'Id not found' }	
		end
end