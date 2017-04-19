require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get games_url
    assert_response :success
  end

  test "should get new" do
    get new_game_url
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post games_url, params: { game: { color1: @game.color1, color2: @game.color2, custom: @game.custom, description: @game.description, discount: @game.discount, logo: @game.logo, name: @game.name, perso1: @game.perso1, perso2: @game.perso2, ref: @game.ref, vuforia_name: @game.vuforia_name } }
    end

    assert_redirected_to game_url(Game.last)
  end

  test "should show game" do
    get game_url(@game)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_url(@game)
    assert_response :success
  end

  test "should update game" do
    patch game_url(@game), params: { game: { color1: @game.color1, color2: @game.color2, custom: @game.custom, description: @game.description, discount: @game.discount, logo: @game.logo, name: @game.name, perso1: @game.perso1, perso2: @game.perso2, ref: @game.ref, vuforia_name: @game.vuforia_name } }
    assert_redirected_to game_url(@game)
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete game_url(@game)
    end

    assert_redirected_to games_url
  end
end
