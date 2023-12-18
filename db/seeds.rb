# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
Movie.destroy_all

100.times do |index|
  Movie.create!(
    title: "Title #{index}",
    description: "Description #{index}",
    trailer_url: nil,
    release_date: "2022-01-01",
    country: "Description #{index}",
    director: "Description #{index}",
    production: "Description #{index}",
    duration_minutes: 90,
  )
end

puts "Created #{Movie.count} movies"
