require "rails_helper"

RSpec.describe "Movies", type: :request do
  def login
     user = User.create!({
      name: Faker::Name.name,
      email: Faker::Internet.email(domain: "example.com"),
      password: "123123",
    })

    sign_in user
  end

  before(:each) do
    @genre = Genre.create!(name: Faker::Name.name)
  end

  let (:movie_params) {
    { 
      movie: {
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
  }

  describe "GET #index" do
    it "returns a success response" do
      get movies_url
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      movie = Movie.create!(movie_params[:movie])
      get movie_url(movie)
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      login
      get new_movie_url
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new movie" do
      login
      expect {
        post movies_url, params: movie_params
      }.to change(Movie, :count).by(1)
      expect(response).to redirect_to(movie_url(Movie.last))
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      login
      movie = Movie.create!(movie_params[:movie])
      get edit_movie_url(movie)
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    it "updates the movie" do
      login
      movie = Movie.create!(movie_params[:movie])
      movie_params[:movie][:title] = 'Updated Movie'
      put movie_url(movie), params: movie_params
      movie.reload
      expect(movie.title).to eq("Updated Movie")
      expect(response).to redirect_to(movie_url(movie))
    end
  end

  describe "DELETE #destroy" do
    it "destroys the genre" do
      login
      movie = Movie.create!(movie_params[:movie])
      expect {
        delete movie_url(movie)
      }.to change(Movie, :count).by(-1)

      expect(response).to redirect_to(movies_url)
    end
  end
end
