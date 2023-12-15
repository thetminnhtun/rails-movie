class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :poster_url
      t.string :trailer_url
      t.date :release_date
      t.string :country
      t.string :director
      t.string :production
      t.integer :duration_minutes

      t.timestamps
    end
  end
end
