class OwnerMailer < ApplicationMailer
	default from: 'optics123@yopmail.com'

	def welcome_email
		byebug
		@owner = params[:owner]
		# @url = 'http://example.com/login'
		mail(	to: 'optics12345@yopmail.com', 
					subject: 'Welcome to My Site') # do |format|
				# format.html { render 'another_template' }
				# format.text { render plain: 'Render Text' }
		# end
	end
end
