require 'rails_helper'
RSpec.describe LocationsController do
	describe 'GET index' do
		it 'has a 200 code' do
			request.headers['Authorization'] = token
			get :index
			expectations(response.status).to eq(200)
		end
		# it 'assigns locations' do
		# 	location = Location.create
		# 	get :index
		# 	expect(assigns(:location)).to eq([location])
		# end
	end
end