class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_many :hotells
  has_many :bookings
end
