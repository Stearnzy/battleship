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
    # board_specs = CellGenerator.new(4, 4)
    # board_specs.populate_cell_names
    # player_board = Board.new(board_specs.cell_names, @height, @width)
    # computer_board = Board.new(board_specs.cell_names, @height, @width)
    # gameplay = GamePlay.new(board_specs.cell_names, computer_board, player_board)
    cell_names = ["A1"]
    player_board = Board.new(cell_names, 1, 1)
    computer_board = Board.new(cell_names, 1, 1)
    gameplay = GamePlay.new(cell_names, computer_board, player_board)
    assert_instance_of GamePlay, gameplay
  end

  def test_computer_can_fire
    skip
    # Needs reworking...
    cell_names = ["A1", "A2", "A3"]
    player_board = Board.new(cell_names, 1, 3)
    computer_board = Board.new(cell_names, 1, 3)
    player_submarine = Ship.new("Submarine", 2)
    # Running pry here shows only one cell when entering player_board.cells
    require "pry"; binding.pry

    player_board.place(player_submarine, ["A1", "A2"])
    gameplay = GamePlay.new(cell_names, computer_board, player_board)
    @computer_shot = "A1"
    refute player_board.cells["A1"].fired_upon?
    gameplay.turn_computer_shot
    assert player_board.cells["A1"].fired_upon?
  end

  def test_computer_can_win
    # Needs work too
    cell_names = ["A1"]
    player_board = Board.new(cell_names, 1, 1)
    computer_board = Board.new(cell_names, 1, 1)
    gameplay = GamePlay.new(cell_names, computer_board, player_board)
    @computer_shot = "A1"
  end
end
