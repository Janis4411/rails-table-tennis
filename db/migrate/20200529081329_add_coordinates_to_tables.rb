class AddCoordinatesToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :tables, :latitude, :float
    add_column :tables, :longitude, :float
  end
end
