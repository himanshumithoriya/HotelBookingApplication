class RoomsController < ApiController
  skip_before_action :customer_authenticate_request
  
  def index
    rooms = Room.all
    render json: rooms
  end

  def create
    room = Room.new(room_params)
    if room.save
      render json: room, status: :created
    else
      render json: { data: room.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def room_list_by_hotell_id
    rooms = Room.where(hotell_id: params[:hotell_id])
    render json: rooms, status: :ok
  end

  private

  def room_params
    params.permit(:room_no, :room_category, :status, :occupancy, :hotell_id)
  end
end
