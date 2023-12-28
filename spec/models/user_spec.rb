require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user_params) {
    {
      name: Faker::Name.name,
      email: Faker::Internet.email(domain: "example.com"),
      password: "123123",
    }
  }

  context "validation tests" do
    it "is valid with valid attributes" do
      user = User.new(user_params).save
      expect(user).to eq(true)
    end

    it "is not valid without name" do
      user = User.new(user_params.merge(name: nil)).save
      expect(user).to eq(false)
    end

    it "is not valid without email" do
      user = User.new(user_params.merge(email: nil)).save
      expect(user).to eq(false)
    end

    it "is not valid without password" do
      user = User.new(user_params.merge(password: nil)).save
      expect(user).to eq(false)
    end
  end

  context "scope tests" do
    before(:example) do
      User.new(user_params.merge(name: 'First Name', email: 'first@example.com')).save
      User.new(user_params.merge(name: 'Second Name', email: 'second@example.com')).save
    end
    
    it "should return all users" do
      expect(User.all.size).to eq(2)
    end

    it "should return filtered users" do
      expect(User.with_filter('First Na').size).to eq(1)
      expect(User.with_filter('Second Na').size).to eq(1)
      expect(User.with_filter('first@example').size).to eq(1)
      expect(User.with_filter('second@example').size).to eq(1)
      expect(User.with_filter('example.com').size).to eq(2)
    end
  end
end
