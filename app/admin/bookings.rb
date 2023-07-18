ActiveAdmin.register Booking do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :customer_name, :mobile_no, :room_type, :member, :user_id, :room_id, :booking_aplhanumeric_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:customer_name, :mobile_no, :room_type, :member, :user_id, :room_id, :booking_aplhanumeric_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
