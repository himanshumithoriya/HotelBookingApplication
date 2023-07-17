class HotellSerializer < ActiveModel::Serializer
  attributes :id, :name, :contact, :address, :status, :image

  belongs_to :location
  has_many :rooms

  def image
    object.image.url
  end
end
