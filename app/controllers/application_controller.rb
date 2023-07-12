class ApplicationController < ActionController::API
	include JsonWebToken
	before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end
  
	before_action :owner_authenticate_request
	before_action :customer_authenticate_request
	

	private
		def owner_authenticate_request
			header = request.headers["Authorization"] 
			header = header.split(" ").last if header
			decoded = jwt_decode(header)
			@current_owner = User.find(decoded[:owner_id])
		end

		def customer_authenticate_request
			header = request.headers["Authorization"] 
			header = header.split(" ").last if header
			decoded = jwt_decode(header)
			@current_customer = User.find(decoded[:customer_id])
		end		
end
