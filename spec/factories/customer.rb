FactoryBot.define do
	factory :customer do
		name { Faker::Name.name_with_middle }
		email  { Faker::Internet.email }
		password { 'r123' }
		type { 'Customer' }		
	end
end