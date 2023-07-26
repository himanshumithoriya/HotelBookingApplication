class OwnersController < ApiController
  skip_before_action :authenticate_request, only: [:create]
  skip_before_action :check_customer
  skip_before_action :check_owner, only: [:create]

  def create
    # byebug
    @owner = Owner.new(owner_params)
    # respond_to do |format|
      if @owner.save
        byebug
        OwnerMailer.with(owner: @owner).welcome_email.deliver_later
        # format.html { redirect_to(@owner, notice: 'Owner was successfully created.') }
        # format.json { render json: @owner, status: :created, location: @owner}
        render json: @owner, status: :ok
      else
        # format.json { render json: @owner.errors, status: :unprocessable_entity }
        render json: { error: "Registration failed" }
      end
    # end
  end

  private

  def owner_params
    params.permit(:name, :email, :password)
  end
end
