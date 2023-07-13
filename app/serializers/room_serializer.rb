class RoomSerializer < ActiveModel::Serializer
  attributes :id, :room_no, :room_category, :hotel

  # belongs_to :hotell
  def hotel
    object.hotell.name
  end
  # has_many :bookings

end
