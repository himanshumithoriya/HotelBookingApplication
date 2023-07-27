class OwnerMailer < ApplicationMailer
	default from: 'himanshumithoriya08@gmail.com'

	def welcome_email
		byebug
		@owner = params[:owner]
		# @url = 'http://example.com/login'
		mail(	to: 'optics123@yopmail.com', 
					subject: 'Welcome to My Site') # do |format|
				# format.html { render 'another_template' }
				# format.text { render plain: 'Render Text' }
		# end
	end
end
