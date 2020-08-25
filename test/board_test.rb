require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new
    assert_instance_of Board, board
  end

  def test_cells_exist
    board = Board.new
    board.cells
    assert_equal 16, board.coordinates.keys.length
  end

  def test_validate_coordinates
    board = Board.new
    board.cells
    assert board.valid_coordinate?("A1")
    refute board.valid_coordinate?("E3")
  end
end
