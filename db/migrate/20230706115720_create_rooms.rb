class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.integer :room_no
      t.string :room_category
      t.string :status
      t.integer :occupancy
      t.references :hotell, null: false, foreign_key: true

      t.timestamps
    end
  end
end
