class CustomersController < ApplicationController
  skip_before_action :customer_authenticate_request, only: [:create, :login]
  skip_before_action :owner_authenticate_request
  before_action :set_params, only: [:update, :destroy]

  def index
    @hotel = Booking.all
    render json: @hotel
  end
  
  def create
    @customer = Customer.new(customer_params)
    return render json: @customer if @customer.save
    render json: @customer.errors.full_messages
  end

  def login
    @customer = Customer.find_by(email: params[:email], password: params[:password])
    if @customer
      token = jwt_encode(customer_id: @customer.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Unauthorized user' }, status: :unauthorized
    end
  end

  def open_hotel
    unless params[:status].strip.empty?
      @hotel = Hotell.where(status: params[:status])
      return render json: {message: 'Hotel Unavailable'} unless @hotel.present?  
      render json: @hotel
    else
      render json: { message: 'field can not be blank' }
    end
  rescue
    render json: {message: 'Pass parameter'}
  end

  def search_hotel_by_name
    hotel_by_name()
  end

  # def search_a_hotel_with_rooms
  #   hotel_with_room()
  # end

  def update
    if @customer
      customer = @customer.update(customer_params)
      render json: { message: 'Customer updated' }
    end
  rescue
    render json: { message: 'Customer updation failed' }
  end

  def destroy
    if @customer
      customer = @customer.destroy
      render json: { message: 'Customer deleted' }
    end
  rescue
    render json: { message: 'Customer deletion failed' }
  end

  private

    def customer_params
      params.permit(:name, :email, :password)
    end

    def set_params
      @customer = Customer.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Id not found' }  
    end
end
