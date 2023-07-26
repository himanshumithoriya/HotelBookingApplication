require 'rails_helper'
include JsonWebToken

RSpec.describe "Rooms", type: :request do
	LOGIN_URL = "/user/login"
	ROOM_URL = "/room/create"
	ROOM_LIST_URL = "/room/list"

	let(:user) { FactoryBot.create(:user) }
	let(:room) { FactoryBot.create(:room) }

	before(:each) do
		@token = jwt_encode(user_id: user.id)
	end

	describe "CREATE #room" do
		it "should create a room" do
			post ROOM_URL, params: { room_no: 101, room_category: "normal", status: "available", hotell_id: 1 }, headers: { token: @token }
			expect(response.status).to eq(200)			
		end
	end

	describe "GET #room" do
		it "should return room list by hotell_id" do
			get ROOM_LIST_URL, params: { hotell_id: 1 }, headers: { token: @token }
			expect(response.status).to eq(200)
		end
	end
end