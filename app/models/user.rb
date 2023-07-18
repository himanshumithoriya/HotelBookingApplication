class User < ApplicationRecord
	has_many :hotells, dependent: :destroy
	has_many :bookings, dependent: :destroy

	def owner?
		User.type == 'Owner'
	end

	def customer?
		User.type == 'Customer'
	end
end
