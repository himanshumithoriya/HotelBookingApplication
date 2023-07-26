FactoryBot.define do
	factory :owner do
		name { Faker::Name.name_with_middle }
		email  { Faker::Internet.email }
		password { 'h123' }
		type { 'Owner' }		
	end
end