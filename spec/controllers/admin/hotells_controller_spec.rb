require 'rails_helper'
RSpec.describe Admin::HotellsController, type: :controller do
	include Warden::Test::Helpers
	render_views
	# byebug
	let(:admin_user) { FactoryBot.create(:admin_user) }
	let(:location)  { FactoryBot.create(:location) }
	let(:hotell) { FactoryBot.create(:hotell) }
	let(:owner) { FactoryBot.create(:owner) }
	
	before(:each) do
    sign_in admin_user
  end
	  
  describe 'create hotell' do
  	it 'should create a hotel' do
  		# byebug
  		post :create, params: { name:"radisson", address: "vijay nagar, indore", contact: "9754327", status: "open", location_id: location.id, user_id: owner.id }
  		# expect(response.status).to eq(201)
  		expect(response).to have_http_status(:success)
  	end
  end

  describe 'index hotell' do
  	it 'return all hotels' do
  		get :index
  		expect(response).to have_http_status(:success)
  	end
  end

  describe 'show hotell' do
  	it 'return a specific hotel' do
  		get :show, params: { id: hotell.id}
  		expect(response).to have_http_status(:success)
  	end
  end
end