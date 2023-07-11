class RoomsController < ApplicationController
  skip_before_action :customer_authenticate_request
  before_action :owner_authenticate_request
  
  def create
    @room = Room.new(room_params)
    if @room.save
      render json: @room, status: :created
    else
      render json: {data: @room.errors.full_messages, status: :"Room Creation failed"}
    end
  end

  private
    def room_params
      params.permit(:room_no, :room_category, :status, :occupancy, :hotell_id)
    end
end
