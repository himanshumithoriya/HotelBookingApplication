class Hotell < ApplicationRecord
  has_one_attached :image

  belongs_to :location
  belongs_to :user

  has_many :rooms
  has_many :bookings, through: :room

  validates :name, presence: true 
  validates :address, :contact, presence: true
  validates :status ,presence:true, inclusion: {in: %w(open closed)} 
 
end
