class Table < ApplicationRecord

   def self.create_from_collection(tables_new)
      tables_new.each do |table_hash|
        Table.create(table_hash)
        sleep(0.1)
    end
  end

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  def coordinates
    [longitude, latitude]
  end

  def to_feature
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": coordinates
      },
      "properties": {
        "table_id": id,
        "info_window": ApplicationController.new.render_to_string(
          partial: "tables/info_window",
          locals: { table: self }
        )
      }
    }

end
end


