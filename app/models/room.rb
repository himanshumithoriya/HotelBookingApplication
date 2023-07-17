class Room < ApplicationRecord
  belongs_to :hotell
  has_many :bookings, through: :hotell, dependent: :destroy

  validates :room_no, presence: true, numericality: { only_integer: true }, uniqueness: true
  validates :room_category, presence: true, inclusion: {in: %w(normal deluxe)} 
  validates :status, presence: true, inclusion: {in: %w(available unavailable)} 
  validates :occupancy, numericality: { only_integer: true, less_than_or_equal_to: 2 }
  
 
end
