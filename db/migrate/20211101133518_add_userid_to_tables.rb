class AddUseridToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :tables, :userid, :integer
  end
end
