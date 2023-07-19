class ApiController < ActionController::API
	include JsonWebToken
	  
	before_action :authenticate_request
	before_action :check_owner
	before_action :check_customer
	

	private
		def authenticate_request
			header = request.headers["Authorization"] 
			header = header.split(" ").last if header
			decoded = jwt_decode(header)
			@current_user = User.find(decoded[:user_id])
		rescue
			render json: {message: "Invalid Token"}	
		end

		def check_owner
			return render json: { message: "You are not owner" } unless @current_user.type == 'Owner'
		end

		def check_customer
			return render json: { message: "You are not customer" } unless @current_user.type == 'Customer'
		end

		def search_hotel_by_name
	    hotels = Hotell.where("name like ?", "%"+params[:name]+"%")
		end

		before_action do
    	ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  	end
end