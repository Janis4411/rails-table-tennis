class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :tables do |t|
      t.text :description
      t.string :location

      t.timestamps
    end
  end
end
