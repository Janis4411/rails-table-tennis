# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first

puts "Cleaning database..."
Table.destroy_all

puts "Creating tables..."
table1 = { location: "Rudi-Dutschke-straße 26, Berlin", description: "beautiful table tennis plate" }
table2 = { location: "Kremmener Str.7, Berlin", description: "two nice table tennis plate" }
table3 = { location: "Chausseestraße 88, Berlin", description: "great table tennis plate" }
table4 = { location: "Jablonskistraße 23, Berlin", description: "old table tennis plate" }
table5 = { location: "Kremmener Str.1, Berlin", description: "average table tennis plate" }

@tables_new.each do |attributes|
  table = Table.create!(attributes)
  puts "Created #{table.description}"
end
puts "Finished!"
