class OwnersController < ApiController
  skip_before_action :authenticate_request, only: [:create]
  skip_before_action :check_customer
  skip_before_action :check_owner, only: [:create]

  def create
    owner = Owner.new(owner_params)
    if owner.save
      render json: owner, status: :ok
    else
      render json: { error: "Registration failed" }
    end
  end

  # def login
  #   owner = Owner.find_by(email: params[:email], password: params[:password])
  #   if owner
  #     token = jwt_encode(owner_id: owner.id)
  #     render json: { token: token }, status: :ok
  #   else
  #     render json: { error: 'Unauthorized user' }, status: :unauthorized
  #   end
  # end

  private

  def owner_params
    params.permit(:name, :email, :password)
  end
end
