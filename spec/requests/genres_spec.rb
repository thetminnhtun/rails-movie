require 'rails_helper'

RSpec.describe "Genres", type: :request do
  def login
    user = User.create!({
      name: Faker::Name.name,
      email: Faker::Internet.email(domain: "example.com"),
      password: "123123",
    })

    sign_in user
  end

  before(:each) do
    login
  end
  
  describe "GET #index" do
    it "returns a success response" do
      get genres_url
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get new_genre_url
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    let(:genre_params) {
      { genre: {
        name: Faker::Name.name,
      } }
    }
    it "creates a new genre" do
      expect {
        post genres_url, params: genre_params
      }.to change(Genre, :count).by(1)
      expect(response).to redirect_to(genres_url)
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      genre = Genre.create!(name: Faker::Name.name)
      get edit_genre_url(genre)
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    let(:genre_params) {
      { genre: {
        name: 'Updated Genre',
      } }
    }
    it "updates the genre" do
      genre = Genre.create!(name: 'Created Genre')
      put genre_url(genre), params: genre_params
      genre.reload
      expect(genre.name).to eq("Updated Genre")
      expect(response).to redirect_to(genres_url)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the genre" do
      genre = Genre.create!(name: Faker::Name.name)
      expect {
        delete genre_url(genre)
      }.to change(Genre, :count).by(-1)

      expect(response).to redirect_to(genres_url)
    end
  end
end
