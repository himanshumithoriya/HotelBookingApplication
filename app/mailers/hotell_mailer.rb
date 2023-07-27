class HotellMailer < ApplicationMailer
	default from: 'himanshumithoriya08@gmail.com'

	def hotell_mailer
		byebug
		hotel = params[:hotell]
		mail( to: 'optics123@yopmail.com', 
					subject: 'Welcome to My Hotel') 
	end
end
