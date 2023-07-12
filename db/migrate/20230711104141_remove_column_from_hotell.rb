class RemoveColumnFromHotell < ActiveRecord::Migration[7.0]
  def change
    remove_column :hotells, :image, :string
  end
end
