class Hotell < ApplicationRecord
  belongs_to :location
  belongs_to :user

  has_many :rooms
  has_many :bookings, through: :rooms

  validates :name, presence: true 
  validates :address, :contact, presence: true
  validates :status ,presence:true, inclusion: {in: %w(open closed)} 
 
end
