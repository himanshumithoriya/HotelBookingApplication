class AddColumnToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :booking_aplhanumeric_id, :string
  end
end
