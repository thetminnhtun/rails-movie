json.extract! movie, :id, :title, :description, :poster_url, :trailer_url, :release_date, :country, :director, :production, :duration_minutes, :created_at, :updated_at
json.url movie_url(movie, format: :json)
