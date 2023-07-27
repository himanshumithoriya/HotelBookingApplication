require 'rails_helper'
include JsonWebToken

RSpec.describe HotellsController, type: :controller do
	describe 'POST create' do
		let(:user) { create :user }
		before(:each) do
			@token = jwt_encode(user_id: user.id)
		end
		it 'should accepts the params' do
			post :create, params: {
												name: Faker::Name.name_with_middle, 
												address: 'vijay nagar, indore' ,
												contact: '9109372240',
												status: 'open',
												location_id: 1
														}, headers: {token: @token}
			expect(response.status).to eq(200)
		end
	end

	# describe 'GET index' do
	# 	it 'has 200 status code' do
	# 		get :index
	# 		expect(response.status).to eq(200)
	# 	end
	# end

	# describe 'GET show/:id' do
	# 	it '' do
	# 		# get :show
	# 	end
	# end
end
