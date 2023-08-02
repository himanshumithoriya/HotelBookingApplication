require "whatsapp"
class HotellsController < ApiController
	skip_before_action :check_customer
	before_action :set_params, only: [:show, :destroy]

	# action_item :view_pdf, only: :show do
  #   link_to 'View PDF', view_pdf_admin_hotell_path(resource), target: '_blank'
  # end
	 
 	def index
		hotels =	if params[:location].present?
			 			 		search_hotel_by_location()
					  	elsif params[:name].present?
								search_hotel_by_name()
							else
								hotels = Hotell.all
							end 
	  render json: hotels 
 	end

 	def show
 		hotel = @current_user.hotells
 		# respond_to do |format|
	  #   format.html # render existing view
	  #   format.pdf do
	  #     generate_pdf(hotell)
    # end

		respond_to do |format|
		    format.html # render existing view
		    format.json
		    format.pdf { 	send_data @hotel.receipt.render, 
		    							filename: "#{@hotel.created_at.strftime("%Y-%m-%d")}"-gorails-receipt.pdf,
		    						  type: "application/pdf",disposition: :inline
	    							}
    end    
 		# return unless hotel.present?
		# render json: hotel
 	end

	def create
		byebug
		hotel = @current_user.hotells.new(hotel_params)
	  if hotel.save
	  	HotellMailer.with(hotel: hotel).hotell_mailer.deliver_later
      render json: hotel, status: :created
    else
      render json: { error: hotel.errors.full_messages }, status: :unprocessable_entity
    end
	end
		
	def destroy
		if @hotel
			@hotel.destroy
			render json: { message: "Hotel Deleted !!!" }, status: :ok
		end
	end
	
 	private

		def hotel_params
			params.permit(:name, :address, :contact, :status, :location_id, :image)
		end

		def set_params
			@hotel = @current_user.hotells.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			render json: {message: "Id not found"}	
		end

		def search_hotel_by_location
		  hotels = Hotell.joins(:location).where('locations.name like ?', "%#{params[:location]}%")
		  # hotels = Hotell.includes([:location]).where('locations.name like ?', "%#{params[:location]}%")
		end

		def generate_pdf(hotell)
  		# same content you posted
		end
end







  #