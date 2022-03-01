require "test_helper"

class Api::Pokemon::PokemonControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_pokemon_pokemon_index_url
    assert_response :success
  end

  test "should get show_all" do
    get api_pokemon_pokemon_show_all_url
    assert_response :success
  end

  test "should get show_one" do
    get api_pokemon_pokemon_show_one_url
    assert_response :success
  end

  test "should get create" do
    get api_pokemon_pokemon_create_url
    assert_response :success
  end

  test "should get querys" do
    get api_pokemon_pokemon_querys_url
    assert_response :success
  end
end
