require 'test_helper'

class Api::V1::MoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:one)
  end

  test "should get index" do
    get api_v1_movies_url, as: :json
    assert_response :success
  end

  test "should create movie" do
    assert_difference('Movie.count') do
      post api_v1_movies_url, params: { movie: { description: @movie.description, image: @movie.image, name: @movie.name, user_id: @movie.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show movie" do
    get api_v1_movie_url(@movie), as: :json
    assert_response :success
  end

  test "should update movie" do
    patch api_v1_movie_url(@movie), params: { movie: { description: @movie.description, image: @movie.image, name: @movie.name, user_id: @movie.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy movie" do
    assert_difference('Movie.count', -1) do
      delete api_v1_movie_url(@movie), as: :json
    end

    assert_response 204
  end
end
