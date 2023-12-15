require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:one)
  end

  test "should get index" do
    get movies_url
    assert_response :success
  end

  test "should get new" do
    get new_movie_url
    assert_response :success
  end

  test "should create movie" do
    assert_difference("Movie.count") do
      post movies_url, params: { movie: { country: @movie.country, description: @movie.description, director: @movie.director, duration_minutes: @movie.duration_minutes, poster_url: @movie.poster_url, production: @movie.production, release_date: @movie.release_date, title: @movie.title, trailer_url: @movie.trailer_url } }
    end

    assert_redirected_to movie_url(Movie.last)
  end

  test "should show movie" do
    get movie_url(@movie)
    assert_response :success
  end

  test "should get edit" do
    get edit_movie_url(@movie)
    assert_response :success
  end

  test "should update movie" do
    patch movie_url(@movie), params: { movie: { country: @movie.country, description: @movie.description, director: @movie.director, duration_minutes: @movie.duration_minutes, poster_url: @movie.poster_url, production: @movie.production, release_date: @movie.release_date, title: @movie.title, trailer_url: @movie.trailer_url } }
    assert_redirected_to movie_url(@movie)
  end

  test "should destroy movie" do
    assert_difference("Movie.count", -1) do
      delete movie_url(@movie)
    end

    assert_redirected_to movies_url
  end
end
