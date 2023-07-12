class CustomersController < ApplicationController
	before_action :customer_authenticate_request
  skip_before_action :owner_authenticate_request

  def index
    @hotel = Booking.all
    render json: @hotel
  end

  def create
     @customer = Customer.new(customer_params)
    if @customer.save
      render json: @customer, status: :ok
    else
      render json: {error: "Registration failed"}
    end
  end

  def login
    @customer = Customer.find_by(email: params[:email], password: params[:password])
    if @customer
      token = jwt_encode(customer_id: @customer.id)
      render json: {token: token}, status: :ok
    else
      render json: {error: "Unauthorized user"}, status: :unauthorized
    end
  end

  def open_hotel
    @hotel = Hotell.where(status: params[:status])
    unless @hotel.empty?
      render json: @hotel
    end
    rescue
      render json: {message: "Hotel Unavailable"}
  end

  def search_hotel_by_name
    unless params[:name].strip.empty?
      @hotel = Hotell.where("name like ?", "%"+params[:name].strip+"%")
      unless @hotel.empty?
        render json: @hotel
      else
        render json: {error: "Couldn't find any hotel with this name"}
      end
    else
      render json: {message: "field can not be blank"}
    end
  end

  

  def search_a_hotel_with_rooms
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

  

  def see_bookings
    byebug
    @bookings = @current_customer.bookings
    unless @bookings.empty?
      render json: @bookings
    end
    rescue
      render json: {message: "No Booking found"}
  end


  def filter_bookings_by_location
    booking =ActiveRecord::Base.connection.execute("select bookings.customer_name, bookings.mobile_no from bookings inner join users on users.id = bookings.user_id inner join rooms on rooms.id = bookings.room_id inner join hotells on hotells.id = rooms.hotell_id inner join locations on locations.id = hotells.location_id where users.id = #{@current_customer.id} and locations.name = '#{params[:name]}'")
    unless booking.empty?
      render json: booking
    end
    rescue
      render json: {message: "booking not found"}
  end

  def show
    @booking = Booking.find(params[:id])
    unless @booking.nil?
      render json: @booking
    end
    rescue 
      render json: {message: "Booking not found"}
     end

  
  def update
    customer = Customer.find(params[:id])
    if customer
      customer = customer.update(name: params[:name], email: params[:email], password: params[:password])
      render json: customer
    end
    rescue
      render json: {message: "Customer updation failed"}
  end

  def destroy
    customer = Customer.find(params[:id])
    if customer
      customer = customer.destroy
      render json: {message: "Customer deleted"}
    end
    rescue
      render json: {message: "Customer deletion failed"}
  end

  private
    def customer_params
      params.permit(:name, :email, :password)
    end
end
