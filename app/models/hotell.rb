class Hotell < ApplicationRecord
  # after_create :send_message

  has_one_attached :image, dependent: :destroy

  belongs_to :location
  belongs_to :user

  has_many :rooms, dependent: :destroy
  
  validates :name, presence: true 
  validates :address, :contact, presence: true
  validates :status ,presence:true, inclusion: { in: %w(open closed) } 

 #  def send_message
 #    byebug
 #   client = Twilio::REST::Client.new
 #   client.messages.create({
 #                            from: ENV['TWILIO_PHONE_NUMBER'],
 #                            to: '+916261715665',
 #                            body: 'Hello there! This is a test'
 #                          })
 # end
end
