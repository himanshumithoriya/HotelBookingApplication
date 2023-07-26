FactoryBot.define do
	factory :hotell do
		name { Faker::Name.name_with_middle }
		address { 'vijay nagar, indore' }
		contact { '9109372240' }
		status { 'open' } 
		location_id { 1 }
		user_id { 1 }
	end
end