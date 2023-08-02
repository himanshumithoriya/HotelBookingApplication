require 'rubygems'
require 'twilio-ruby'
class TwilioTextMessenger
  # attr_reader :client

  # def initialize
  #   @client = Twilio::REST::Client.new account_sid, auth_token
  # end

  # private

  # def account_sid
  #   # Rails.application.credentials.twilio[:account_sid]
  #   Rails.application.credentials.ENV["TWILIO_ACCOUNT_SID"]
  # end

  # def auth_token
  #   Rails.application.credentials.twilio[:auth_token]
  # end

  # def phone_number
  #   Rails.application.credentials.twilio[:phone_number]
  # end

#.........................
  # def send_text(number, text_content)
  #   byebug
  #   # account_id = ENV['AC6efa940237805bc917277d9f410c286d']
  #   # auth_token = ENV['f9c7609c8bd3e3f068b13c14fcd74cc4']
  #   a = 'AC6efa940237805bc917277d9f410c286d'
  #   at = 'f9c7609c8bd3e3f068b13c14fcd74cc4'
  #   @client = Twilio::REST::Client.new a, at
  #   @client.messages.create(
  #         from: '+14708285448',
  #         # from: Rails.application.secrets.twilio_phone_number || ENV['TWILIO_PHONE_NUMBER'],
  #         to: number,
  #         body: text_content
  #     )
  # end




  def sms
    # Find your Account SID and Auth Token at twilio.com/console
    # and set the environment variables. See http://twil.io/secure
    # account_sid = ENV['TWILIO_ACCOUNT_SID']
    # auth_token = ENV['TWILIO_AUTH_TOKEN']
    account_sid = 'AC6efa940237805bc917277d9f410c286d'
    auth_token = 'f9c7609c8bd3e3f068b13c14fcd74cc4'
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    conversation = @client.conversations
                          .v1
                          .conversations
                          .create(friendly_name: 'testing')

    # puts conversation.sid
  end

  def sms_receiver
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    participant = @client.conversations
                         .v1
                         .conversations('CHXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')
                         .participants
                         .create(
                            messaging_binding_address: '+15558675310',
                            messaging_binding_proxy_address: '+14708285448'
                          )
  end
end


