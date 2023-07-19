class UsersController < ApiController
	skip_before_action :authenticate_request
	skip_before_action :check_owner
	skip_before_action :check_customer

	def login
		user = User.find_by(email: params[:email], password: params[:password])
    if user
      token = jwt_encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Unauthorized user' }, status: :unauthorized
    end
	end
end