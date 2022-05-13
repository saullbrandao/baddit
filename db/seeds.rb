# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

('a'..'e').each do |i|
  Community.create(name: "Community #{i}")
end

Community.all.each do |community|
  (1..3).each do |i|
    community.posts.create(title: "#{community.name} 's post #{i}", body: "Body #{i}", votes: rand(-10..10))
  end
end