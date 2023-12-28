require 'rails_helper'

RSpec.describe Genre, type: :model do
  context 'validation tests' do
    it "is valid with valid attributes" do
      genre = Genre.new(name: "Sample Genre").save
      expect(genre).to eq(true)
    end

    it 'is not valid without name' do
      genre = Genre.new(name: nil).save
      expect(genre).to eq(false)
    end
  end

  context 'scope tests' do
    # let(:params) { { name: "Sample Title" } }
    before(:each) do
      Genre.new(name: "Sample Genre").save
      Genre.new(name: "Filtered Genre").save
    end

    it 'should return all genres' do
      expect(Genre.all.size).to eq(2)
    end
    
    it 'should return filtered genres' do
      expect(Genre.with_filter("Filtered").size).to eq(1)
    end
  end

  context 'relationship test' do
    it "should have many teams" do
      genre = Genre.reflect_on_association(:movies)
      expect(genre.macro).to eq(:has_and_belongs_to_many)
    end
  end
end
