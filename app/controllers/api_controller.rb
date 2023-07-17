class ApiController < ActionController::API
	include JsonWebToken
	  
	before_action :owner_authenticate_request
	before_action :customer_authenticate_request
	

	private
		def owner_authenticate_request
			header = request.headers["Authorization"] 
			header = header.split(" ").last if header
			decoded = jwt_decode(header)
			@current_owner = User.find(decoded[:owner_id])
		rescue
			render json: {message: "Invalid Token"}	
		end

		def customer_authenticate_request
			header = request.headers["Authorization"] 
			header = header.split(" ").last if header
			decoded = jwt_decode(header)
			@current_customer = User.find(decoded[:customer_id])
		rescue
			render json: {message: "Invalid Token"}
		end		

		def hotel_by_name
			unless params[:name].strip.empty?
		    @hotel = Hotell.where("name like ?", "%"+params[:name]+"%")
		    return render json: {message: "Couldn't find any hotel with this name"} unless @hotel.present?
		      render json: @hotel
	    else
		      render json: {message: "field can't be blank"}
	    end
	  rescue
	    render json: {message: "Please pass parameter"}
		end

		before_action do
    	ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  	end
end