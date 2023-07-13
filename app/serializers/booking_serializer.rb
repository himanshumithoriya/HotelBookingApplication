class BookingSerializer < ActiveModel::Serializer
  attributes :customer_name, :mobile_no, :member, :booking_aplhanumeric_id, :room_no, :hotel

  def room_no
    object.room.room_no
  end

  def hotel
    object.room.hotell.name
  end
  # belongs_to :user
  # belongs_to :room
end
