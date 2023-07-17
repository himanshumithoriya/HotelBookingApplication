class RoomSerializer < ActiveModel::Serializer
  attributes :id, :room_no, :room_category, :hotel

  def hotel
    object.hotell.name
  end
end
