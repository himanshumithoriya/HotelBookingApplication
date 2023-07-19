class User < ApplicationRecord
	has_many :hotells, dependent: :destroy
	has_many :bookings, dependent: :destroy
end
