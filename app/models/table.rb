class Table < ApplicationRecord
  has_one_attached :table_photo, dependent: :destroy
  validates :description, presence: true, length: { minimum: 10 }
  validates :location, presence: true, length: { minimum: 10 }

  after_commit :add_default_cover, on: [:create, :update]

   def self.create_from_collection(tables_new)
      tables_new.each do |table_hash|
        Table.find_or_create_by(table_hash)
        sleep(0.3)
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

  private

  def add_default_cover
    unless table_photo.attached?
      file = URI.open("https://res.cloudinary.com/dw0fvtaxe/image/upload/v1638271635/development/1h38rufpqlj2bhamv1sgmasnvym5.jpg")
    self.table_photo.attach(io: file, filename: 'default-image.jpg')
  end

  end
end


