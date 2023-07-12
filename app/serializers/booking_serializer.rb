class BookingSerializer < ActiveModel::Serializer
  attributes :customer_name, :mobile_no, :member

  
  belongs_to :user
  belongs_to :room
end
