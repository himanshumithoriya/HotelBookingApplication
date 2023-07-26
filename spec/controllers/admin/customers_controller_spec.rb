require 'rails_helper'
RSpec.describe Admin::CustomersController, type: :controller do
	include Warden::Test::Helpers
	render_views
	let(:admin_user) { FactoryBot.create(:admin_user) }
	let(:location)  { FactoryBot.create(:location) }
	let(:hotell) { FactoryBot.create(:hotell) }
	let(:customer) { FactoryBot.create(:customer) }

	before(:each) do
    sign_in admin_user
  end

  describe 'create customer' do
  	it 'should create a customer' do
  		post :create, params: { name: "Rahul", email: "rahul123@gmail.com", password: "r123", type: "Customer" }
  		expect(response).to have_http_status(:success)
		end
  end

  describe 'index hotell' do
  	it 'return all hotels' do
  		get :index
  		expect(response).to have_http_status(:success)
  	end
  end

  # describe 'update customer' do
  # 	it 'should update customer' do
  # 		get :update, params: { id: customer.id}
  # 		expect(response).to have_http_status(:success)
  # 	end
  # end
end