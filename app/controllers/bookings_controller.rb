class BookingsController < ApiController
	skip_before_action :owner_authenticate_request
	before_action :set_params, only: [:show, :destroy]

	def create
		hotel = Hotell.find_by(id: params[:bookings][:hotell_id])
		member = params[:bookings][:member]
		required_rooms = (member / 2) + (member % 2)
		rooms = hotel.rooms.where(status: "available").where(room_category: params[:bookings][:room_type])
		avl_rooms = rooms.count
		if avl_rooms < required_rooms
			render json: {message: "Rooms not available"}, status: :not_found
		else
			rooms = rooms.limit(required_rooms)
			rooms.each do |room|
				booking = @current_customer.bookings.new(booking_params)
				booking.room_id = room.id
				(member > 1)? booking.member = 2 : booking.member = 1
				member -= 2
				if booking.save
					room.update(status: 'unavailable')
				end
			end
			render json: { message: 'Room Booked!!!' }, status: :ok
		end 
	end

	def index
    bookings = @current_customer.bookings
    return render json: { message: 'No Booking found' } unless bookings.present?
    render json: bookings, status: :ok
  end

  def filter_bookings_by_location
    bookings = ActiveRecord::Base.connection.execute("select rooms.room_no, bookings.booking_aplhanumeric_id, bookings.member from bookings INNER JOIN users on users.id = bookings.user_id INNER JOIN rooms on rooms.id = bookings.room_id INNER JOIN hotells on hotells.id = rooms.hotell_id INNER JOIN locations on locations.id = hotells.location_id where users.id = #{@current_customer.id} and locations.name like '%#{params[:name]}%'")
    return render json: { message: 'booking not found' } unless bookings.present?
    render json: bookings, status: :ok
  end

  def show
    return render json: @booking, status: :ok if @booking.present?
  end

  def destroy
  	if @booking
  		booking = @booking.destroy
  		render json: { message: "Booking deleted" }, status: :ok	
  	end
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