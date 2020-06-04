class Table < ApplicationRecord

   def self.create_from_collection(tables_new)
      tables_new.each do |table_hash|
        Table.create(table_hash)
    end
  end

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

end


