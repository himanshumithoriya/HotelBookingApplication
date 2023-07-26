require 'rails_helper'
include JsonWebToken

RSpec.describe 'Users', type: :request do
	USER_URL = "/owners"
	LOGIN_URL = "/user/login"

	let(:user) { FactoryBot.create(:user) }

	before(:each) do
		@token = jwt_encode(user_id: user.id)
	end

	describe "CREATE #user" do
		it 'should create a user account' do
			post USER_URL, params: { name: "Himanshu", email: "himanshu123@gmail.com", password: "h123", type: "Owner" }
			expect(response.status).to eq(200)			
		end
	end

	describe "LOGIN #user" do
		it 'should login a user' do
			User.create!(email: "himanshu123@gmail.com", password: "h123", type: 'Owner', name: 'test')
			post LOGIN_URL, params: { "email" => "himanshu123@gmail.com", "password" => "h123"}
			expect(response.status).to eq(200)
		end
	end
end