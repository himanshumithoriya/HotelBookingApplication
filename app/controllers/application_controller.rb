class ApplicationController < ActionController::API
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

		# def hotel_with_room
		# 	hotel_with_room = []
	  #   return render json: { message: "Field can't be blank" } if params[:name].strip.empty?
	  #   hotels = Hotell.where("name LIKE ?", "%#{params[:name].strip}%")
	  #   return render json: {message: "hotel not found"} unless hotels.present?
	  #   # hotels.each do |hotel|
	  #   #   hotel_with_room << hotel
	  #   # end
	  #   render json: hotels
    # rescue
    #   render json: {message: "please pass parameter"}
		# end

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
