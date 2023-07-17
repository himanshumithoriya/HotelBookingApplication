class BookingSerializer < ActiveModel::Serializer
  attributes :id, :member, :booking_aplhanumeric_id, :room_no, :hotel

  def room_no
    object.room.room_no
  end

  def hotel
    object.room.hotell.name
  end
end
