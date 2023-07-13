class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :customer_name, presence:true
  validates :mobile_no, presence: true
  validates :room_type, presence: true
  validates :member, numericality: { only_integer: true }
  enum room_type: [:normal, :deluxe]

  before_save :booking_id_generator

  def booking_id_generator
    self.booking_aplhanumeric_id = SecureRandom.hex[0..7]
  end
end
