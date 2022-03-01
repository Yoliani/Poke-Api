require "test_helper"

class Api::Pokemon::PokemonControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_pokemon_pokemon_index_url
    assert_response :success
  end

  test "should get show_one" do
    get api_pokemon_pokemon_show_one_url
    assert_response :success
  end

  test "should get show_limit" do
    get api_pokemon_pokemon_show_limit_url
    assert_response :success
  end

  test "should get query" do
    get api_pokemon_pokemon_query_url
    assert_response :success
  end
end
