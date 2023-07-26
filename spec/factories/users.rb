FactoryBot.define do
    factory :user do
      name  { 'Abc' }
      email { 'abc123@gmail.com' }
      password { 'a123' }
      type { 'Owner' }
    end
  end 