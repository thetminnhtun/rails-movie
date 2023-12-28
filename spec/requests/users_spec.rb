require 'rails_helper'

RSpec.describe "Users", type: :request do
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

  let (:user_params) {
    {
      user: {
        name: Faker::Name.name,
        email: Faker::Internet.email(domain: "example.com"),
        password: "123123",
      }
    }
  }

  describe "GET #index" do
    it "returns a success response" do
      get users_url
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get new_user_url
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new user" do
      expect {
        post users_url, params: user_params
      }.to change(User, :count).by(1)
      expect(response).to redirect_to(users_url)
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      user = User.create!(user_params[:user])
      get edit_user_url(user)
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    it "updates the user" do
      user = User.create!(user_params[:user])
      user_params[:user][:name] = 'Updated User'
      put user_url(user), params: user_params
      user.reload
      expect(user.name).to eq("Updated User")
      expect(response).to redirect_to(users_url)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the genre" do
      user = User.create!(user_params[:user])
      expect {
        delete user_url(user)
      }.to change(User, :count).by(-1)

      expect(response).to redirect_to(users_url)
    end
  end
end
