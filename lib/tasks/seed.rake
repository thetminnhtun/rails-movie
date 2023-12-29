namespace :seed do
  desc "Seeds"
  task users: :environment do
    User.where.not(name: "Admin").destroy_all

    50.times do |index|
      User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email(domain: "example.com"),
        password: "123123",
      )
    end

    puts "Created #{User.count} users"
  end

  task movies: :environment do
    Movie.destroy_all

    images = 11.times.to_a
    1.times do |index|
      movie = Movie.create!(
        title: Faker::Name.name,
        description: Faker::Lorem.paragraph_by_chars,
        trailer_url: nil,
        release_date: "2022-01-01",
        country: ["Myanmar", "USA", "Japan"].sample,
        director: Faker::Name.name,
        production: ["20th Century Fox(US)", "Marvel", "DC"].sample,
        duration_minutes: [120, 90, 180].sample,
        genre_ids: [1, 2, 3],
      )

      filename = "#{images.sample}.jpg";
      image = File.open(Rails.root.join("db/fixtures/images/#{filename}"))
      movie.poster.attach(io: image, filename: "#{filename}")
    end

    puts "Created #{Movie.count} movies"
  end
end
