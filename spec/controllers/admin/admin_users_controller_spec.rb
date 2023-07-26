require 'rails_helper'

RSpec.describe Admin::AdminUsersController, type: :controller do
	render_views
	before(:each) do
		@admin = AdminUser.find_or_create_by(email: 'admin@example.com')
		@admin.password = 'password'
		@admin.save
		# sign_user = @admin
		
	end

	describe 'set admin user params' do
		let(:user_params) do
			{
				email: 'admin@example.com',
				password: 'password',
				password_confirmation: 'password'
			}
		end
	end

	describe 'create admin user' do
		post :new, params: user_params
		expect(response.status).to eq(200)
	end
end