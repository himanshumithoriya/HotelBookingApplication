require 'rails_helper'
include JsonWebToken

RSpec.describe "Hotells", type: :request do
	LOGIN_URL = "/user/login"
	HOTEL_URL = "/hotells"
	let(:user) { FactoryBot.create(:user) }
	let(:hotell) { FactoryBot.create(:hotell) }

	before(:each) do
		@token = jwt_encode(user_id: user.id)
	end

	describe "CREATE #hotell" do
		it "should create a hotel" do
			post HOTEL_URL, params: { name: "Taj", address: "abc, mumbai", contact: "9827584494", status: "open", location_id: 3}, headers: { token: @token }
			expect(response.status).to eq(200)
		end
	end

	describe "GET #hotells" do
		it 'should return hotels by location name' do
			get HOTEL_URL, params: { location: "Indore" }, headers: { token: @token }
			expect(response.status).to eq(200)
		end

		it 'should return hotels by name' do
			get HOTEL_URL, params: { name: "radisson" }, headers: { token: @token }
			expect(response.status).to eq(200)
		end

		it 'should return all hotels' do
			get HOTEL_URL, headers: { token: @token }
			expect(response.status).to eq(200)
		end
	end

	


end