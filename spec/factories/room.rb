FactoryBot.define do
	factory :room do
		room_no { 101 }
		room_category { 'normal'}
		status { 'available' }
		occupancy { 2 }
		hotell_id { 1 }
	end
end