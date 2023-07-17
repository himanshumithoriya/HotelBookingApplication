class Hotell < ApplicationRecord
  has_one_attached :image, dependent: :destroy

  belongs_to :location
  belongs_to :user

  has_many :rooms, dependent: :destroy
  
  validates :name, presence: true 
  validates :address, :contact, presence: true
  validates :status ,presence:true, inclusion: {in: %w(open closed)} 
 
end
