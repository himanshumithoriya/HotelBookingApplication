class RoomSerializer < ActiveModel::Serializer
  attributes :id, :room_no, :room_category

  belongs_to :hotell
  # has_many :bookings

end
