require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/cell_generator'
require './lib/game_setup'
require './lib/gameplay'

class GamePlayTest < Minitest::Test
  def test_it_exists
    gameplay = GamePlay.new(:cell_names, setup.computer_cruiser, setup.computer_submarine, setup.player_place_cruiser, setup.player_submarine, setup.computer_board, setup.player_board)
    assert_instance_of GamePlay, gameplay
  end
end
