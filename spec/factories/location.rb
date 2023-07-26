FactoryBot.define do
	factory :location do
		name { Faker::Name.name_with_middle }
	end
end