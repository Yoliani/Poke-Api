require "test_helper"

class PokemonControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pokemon_index_url
    assert_response :success
  end

  test "should get one_fetch" do
    get pokemon_one_fetch_url
    assert_response :success
  end

  test "should get querys" do
    get pokemon_querys_url
    assert_response :success
  end
end
