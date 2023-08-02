require 'twilio_text_messenger'
class CustomersController < ApiController
  skip_before_action :authenticate_request, only: [:create]
  skip_before_action :check_customer, only: [:create]
  skip_before_action :check_owner
    
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
    byebug
    customer = Customer.new(customer_params)
      if customer.save!
        # TwilioTextMessenger.new.send_text('+917223009254', 'Hello hi bye')
        # TwilioTextMessenger.new.sms('+917223009254', 'Hello hi bye')
        TwilioTextMessenger.new.sms()
        # TwilioTextMessenger.new.send_text
        # flash[:message] = "Customer, #{customer.name}, was successfully created!!!"
        # t.call('+916261715665', 'Hello')
        render json: customer, status: :created
      else
        render json: customer.errors.full_messages, status: :unprocessable_entity
      end
    # return render json: customer, status: :created if customer.save
    # render json: customer.errors.full_messages, status: :unprocessable_entity
  end

  def update
    @current_user.update(customer_params)
    render json: { message: 'Customer updated' }
  end

  def destroy
    if @current_user.destroy
      render json: { message: 'Customer deleted' }, status: :deleted
    else
      render json: { message: 'Customer deletion failed' }
    end
  end

  private

    def customer_params
      params.permit(:name, :email, :password)
    end
   
    def open_hotel
      hotels = Hotell.where(status: params[:status])
    end
end
