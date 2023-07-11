class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :customer_name, presence:true
  validates :mobile_no, presence: true
  validates :room_type, presence: true
  validates :member, numericality: { only_integer: true }
  enum room_type: [:normal, :deluxe]

  
end
