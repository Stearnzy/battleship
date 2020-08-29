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

    assert_equal 16, board.cells.keys.length
  end

  def test_it_can_validate_coordinates
    board = Board.new
    board.cells

    assert board.valid_coordinate?("A1")
    assert_equal false, board.valid_coordinate?("E3")
  end

  def test_it_does_not_validate_non_existent_coordinates
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["H1", "N1"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A6", "A9"])
  end

  def test_it_does_not_validate_incorrect_ship_lengths
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_it_does_not_validate_non_consecutive_coordinates
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_it_does_not_validate_diagonal_coordinates
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_it_can_validate_proper_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert board.valid_placement?(submarine, ["A1", "A2"])
    assert board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_it_can_place_ship_onto_board
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    cell_4 = board.cells["A4"]

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
    assert_equal nil, cell_4.ship
  end

  def test_ships_cannot_overlap
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_it_can_render_empty_board
    board = Board.new

    assert_equal "  1 2 3 4 \n" +
                "A . . . . \n" +
                "B . . . . \n" +
                "C . . . . \n" +
                "D . . . . \n", board.render
  end

  def test_it_can_render_ship_on_board
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal "  1 2 3 4 \n" +
                "A S S S . \n" +
                "B . . . . \n" +
                "C . . . . \n" +
                "D . . . . \n", board.render(true)
  end

  def test_it_can_render_a_miss
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A4", "B4", "C4"])

    assert_equal "  1 2 3 4 \n" +
                "A . . . S \n" +
                "B . . . S \n" +
                "C . . . S \n" +
                "D . . . . \n", board.render(true)

    board.cells["D4"].fire_upon
    assert_equal "  1 2 3 4 \n" +
                "A . . . . \n" +
                "B . . . . \n" +
                "C . . . . \n" +
                "D . . . M \n", board.render
    assert_equal "  1 2 3 4 \n" +
                "A . . . S \n" +
                "B . . . S \n" +
                "C . . . S \n" +
                "D . . . M \n", board.render(true)
  end

  def test_if_can_render_a_hit
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A4", "B4", "C4"])

    board.cells["A4"].fire_upon
    assert_equal "  1 2 3 4 \n" +
                 "A . . . H \n" +
                 "B . . . . \n" +
                 "C . . . . \n" +
                 "D . . . . \n", board.render
    assert_equal "  1 2 3 4 \n" +
                 "A . . . H \n" +
                 "B . . . S \n" +
                 "C . . . S \n" +
                 "D . . . . \n", board.render(true)
  end

  def test_it_can_render_a_sink
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A4", "B4", "C4"])

    board.cells["A4"].fire_upon
    board.cells["B4"].fire_upon
    assert_equal "  1 2 3 4 \n" +
                 "A . . . H \n" +
                 "B . . . H \n" +
                 "C . . . . \n" +
                 "D . . . . \n", board.render
    assert_equal "  1 2 3 4 \n" +
                 "A . . . H \n" +
                 "B . . . H \n" +
                 "C . . . S \n" +
                 "D . . . . \n", board.render(true)

    board.cells["C4"].fire_upon
    assert_equal "  1 2 3 4 \n" +
                 "A . . . X \n" +
                 "B . . . X \n" +
                 "C . . . X \n" +
                 "D . . . . \n", board.render
    assert_equal "  1 2 3 4 \n" +
                 "A . . . X \n" +
                 "B . . . X \n" +
                 "C . . . X \n" +
                 "D . . . . \n", board.render(true)
  end
end
