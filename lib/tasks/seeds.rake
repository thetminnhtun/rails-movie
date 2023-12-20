namespace :seeds do
  desc "Seeds"
  task seed_users: :environment do
    User.destroy_all

    User.create!(
      name: "Admin",
      email: "admin@admin.com",
      password: "123123",
    )

    99.times do |index|
      User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email(domain: "example.com"),
        password: "123123",
      )
    end

    puts "Created #{User.count} users"
  end

  task seed_movies: :environment do
    Movie.destroy_all

    100.times do |index|
      Movie.create!(
        title: "Title #{index}",
        description: "Description #{index}",
        trailer_url: nil,
        release_date: "2022-01-01",
        country: "Country #{index}",
        director: "Director #{index}",
        production: "Production #{index}",
        duration_minutes: 90,
      )
    end

    puts "Created #{Movie.count} movies"
  end
end
