require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class GameTest < Minitest::Test
  def test_it_exists
    game = Game.new
    assert_instance_of Game, game
  end

  # def test_game_is_still_going
  #   game = Game.new
  #   @player_board = Board.new
  #   @computer_board = Board.new
    # cell_1 = board.cells["A1"]
    # cell_2 = board.cells["A2"]
    # cell_3 = board.cells["A3"]
  # end

  def test_computer_ship_placement
    skip
    # WTF!!!! Undefined method for cell_names in line 157
    game = Game.new
    @computer_board = Board.new
    @player_board = Board.new
    @computer_board.cells
    game.computer_ship_placement
    require "pry"; binding.pry
    # assert_equal 5,
  end

  def test_player_cruiser_placement
    skip
    # Not sure if I can test this either, since this requires @cruiser_placement,
    # which is defined in player_cruiser_validation_check by requiring user input.
    game = Game.new
    @player_board = Board.new
    @cruiser_placement_entry = ["A1", "A2", "A3"]
    game.player_place_cruiser

  end
end
