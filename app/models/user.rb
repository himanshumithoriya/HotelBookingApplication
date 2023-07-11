class User < ApplicationRecord
	has_many :hotells
	has_many :bookings
end
