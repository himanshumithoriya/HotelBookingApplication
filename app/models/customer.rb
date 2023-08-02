class Customer < User
	# after_create :send_message
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
	validates :password, presence: true


 #  def send_message
 #    byebug
 #   # client = Twilio::REST::Client.new
 #   # client.messages.create({
 #   #                          from: ENV['TWILIO_PHONE_NUMBER'],
 #   #                          to: '+916261715665',
 #   #                          body: 'Hello there! This is a test'
 #   #                        })
 #  	account_sid = ENV['TWILIO_ACCOUNT_SID']
# 		auth_token = ENV['TWILIO_AUTH_TOKEN']
# 		@client = Twilio::REST::Client.new(account_sid, auth_token)

# 		service = @client.verify.v2.services.create(friendly_name: 'MG8180a9650f335587ea238bc186cb3420')
# 		# service = @client.verify.v2.services('MG8180a9650f335587ea238bc186cb3420').fetch
		
 # end
end