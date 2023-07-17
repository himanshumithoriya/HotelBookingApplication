class CustomersController < ApiController
  skip_before_action :customer_authenticate_request, only: [:create, :login]
  skip_before_action :owner_authenticate_request
  before_action :set_params, only: [:update, :destroy]

  def index
    hotels =  if params[:status].present?
                open_hotel()
              elsif params[:name].present?
                search_hotel_by_name()
              else
                hotels= Hotell.all
              end
    if hotels.present?
      render json: hotels, status: :ok
    end
  end
  
  def create
    customer = Customer.new(customer_params)
    return render json: customer, status: :created if customer.save
    render json: customer.errors.full_messages, status: :unprocessable_entity
  end

  def login
    customer = Customer.find_by(email: params[:email], password: params[:password])
    if customer
      token = jwt_encode(customer_id: customer.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Unauthorized user' }, status: :unauthorized
    end
  end

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
      render json: { message: 'Customer deleted' }, status: :deleted
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

    def open_hotel
      hotels = Hotell.where(status: params[:status])
    end
end
