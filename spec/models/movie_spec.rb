require "rails_helper"

RSpec.describe Movie, type: :model do
  before(:each) do
    @genre = Genre.create!(name: Faker::Name.name)
  end

  let (:movie_params) {
    {
      title: Faker::Name.name,
      description: Faker::Lorem.paragraph_by_chars,
      release_date: "2022-01-01",
      genre_ids: [@genre.id],
      duration_minutes: [120, 90, 180].sample,
      trailer_url: nil,
      country: ["Myanmar", "USA", "Japan"].sample,
      director: Faker::Name.name,
      production: ["20th Century Fox(US)", "Marvel", "DC"].sample,
    }
  }

  context "validation tests" do
    it "is valid with valid attributes" do
      movie = Movie.new(movie_params).save
      expect(movie).to eq(true)
    end

    it "is not valid without title" do
      movie = Movie.new(movie_params.merge(title: nil)).save
      expect(movie).to eq(false)
    end

    it "is not valid without description" do
      movie = Movie.new(movie_params.merge(description: nil)).save
      expect(movie).to eq(false)
    end

    it "is not valid without release date" do
      movie = Movie.new(movie_params.merge(release_date: nil)).save
      expect(movie).to eq(false)
    end

    it "is not valid without duration minutes" do
      movie = Movie.new(movie_params.merge(duration_minutes: nil)).save
      expect(movie).to eq(false)
    end

    it "is not valid without genre ids" do
      movie = Movie.new(movie_params.merge(genre_ids: nil)).save
      expect(movie).to eq(false)
    end

    it "is valid without country" do
      movie = Movie.new(movie_params.merge(country: nil)).save
      expect(movie).to eq(true)
    end

    it "is valid without trailer_url" do
      movie = Movie.new(movie_params.merge(trailer_url: nil)).save
      expect(movie).to eq(true)
    end

    it "is valid without director" do
      movie = Movie.new(movie_params.merge(director: nil)).save
      expect(movie).to eq(true)
    end

    it "is valid without production" do
      movie = Movie.new(movie_params.merge(production: nil)).save
      expect(movie).to eq(true)
    end
  end

  context "scope tests" do
    before(:example) do
      Movie.new(movie_params.merge(title: 'First Movie')).save
      Movie.new(movie_params.merge(title: 'Second Movie')).save
    end
    
    it "should return all movies" do
      expect(Movie.all.size).to eq(2)
    end

    it "should return filtered movies" do
      expect(Movie.with_filter('First Movie').size).to eq(1)
    end
  end

  context "relationship tests" do
    it "should have many genres" do
      movie = Movie.reflect_on_association(:genres)
      expect(movie.macro).to eq(:has_and_belongs_to_many)
    end
  end
end
