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
    cell_names = ["A1"]
    player_board = Board.new(cell_names, 1, 1)
    computer_board = Board.new(cell_names, 1, 1)
    gameplay = GamePlay.new(cell_names, computer_board, player_board)

    assert_instance_of GamePlay, gameplay
  end

  def test_game_goes_on_or_not
    cell_names = ["A1", "A2"]
    player_board = Board.new(cell_names, 1, 2)
    computer_board = Board.new(cell_names, 1, 2)
    player_submarine = Ship.new("Submarine", 2)
    player_board.place(player_submarine, ["A1", "A2"])
    computer_submarine = Ship.new("Submarine", 2)
    computer_board.place(computer_submarine, ["A1", "A2"])
    gameplay = GamePlay.new(cell_names, computer_board, player_board)

    assert gameplay.game_is_still_going?
    gameplay.turn_computer_shot
    gameplay.turn_computer_shot
    refute gameplay.game_is_still_going?
  end

  def test_computer_can_fire_upon_and_sink_player_ship
    cell_names = ["A1", "A2"]
    player_board = Board.new(cell_names, 1, 2)
    computer_board = Board.new(cell_names, 1, 2)
    player_submarine = Ship.new("Submarine", 2)
    player_board.place(player_submarine, ["A1", "A2"])
    gameplay = GamePlay.new(cell_names, computer_board, player_board)

    refute player_board.cells["A1"].fired_upon? && player_board.cells["A2"].fired_upon?
    gameplay.turn_computer_shot
    assert player_board.cells["A1"].fired_upon? || player_board.cells["A2"].fired_upon?
    gameplay.turn_computer_shot
    assert player_board.cells["A1"].fired_upon? && player_board.cells["A2"].fired_upon?
    assert player_submarine.sunk?
  end

  def test_computer_can_win
    cell_names = ["A1", "A2"]
    player_board = Board.new(cell_names, 1, 2)
    computer_board = Board.new(cell_names, 1, 2)
    player_submarine = Ship.new("Submarine", 2)
    computer_submarine = Ship.new("Submarine", 2)
    player_board.place(player_submarine, ["A1", "A2"])
    computer_board.place(computer_submarine, ["A1", "A2"])
    gameplay = GamePlay.new(cell_names, computer_board, player_board)
    gameplay.turn_computer_shot
    gameplay.player_board.render
    gameplay.turn_computer_shot
    gameplay.player_board.render

    assert true, gameplay.computer_won?
    assert_equal false, gameplay.player_won?
  end

  def test_player_can_win
    cell_names = ["A1", "A2"]
    player_board = Board.new(cell_names, 1, 2)
    computer_board = Board.new(cell_names, 1, 2)
    player_submarine = Ship.new("Submarine", 2)
    computer_submarine = Ship.new("Submarine", 2)
    player_board.place(player_submarine, ["A1", "A2"])
    computer_board.place(computer_submarine, ["A1", "A2"])
    gameplay = GamePlay.new(cell_names, computer_board, player_board)
    gameplay.turn_player_shot("A1")
    gameplay.turn_player_shot("A2")

    assert_equal false, gameplay.computer_won?
    assert_equal true, gameplay.player_won?
  end

  def test_it_can_identify_hit_cell
    generator = CellGenerator.new
    generator.populate_cell_names
    cell_names = generator.cell_names
    player_cruiser = Ship.new("Cruiser", 3)
    player_board = Board.new(cell_names)
    computer_board = Board.new(cell_names)
    player_board.place(player_cruiser, ["A4", "B4", "C4"])
    gameplay = GamePlay.new(cell_names, computer_board, player_board)

    gameplay.player_board.cells["A4"].fire_upon

    assert ["A4"], gameplay.identify_hit_cell
  end

  def test_it_can_map_surrounding_cells
    generator = CellGenerator.new
    generator.populate_cell_names
    cell_names = generator.cell_names
    player_cruiser = Ship.new("Cruiser", 3)
    player_board = Board.new(cell_names)
    computer_board = Board.new(cell_names)
    player_board.place(player_cruiser, ["C1", "C2", "C3"])
    gameplay = GamePlay.new(cell_names, computer_board, player_board)

    gameplay.player_board.cells["C2"].fire_upon
    gameplay.identify_hit_cell

    assert_equal ["C1", "C3", "B2", "D2"], gameplay.map_surrounding_cells
  end

  def test_it_shoots_surrounding_cells_in_target_mode
    100.times do
      generator = CellGenerator.new
      generator.populate_cell_names
      cell_names = generator.cell_names
      player_cruiser = Ship.new("Cruiser", 3)
      player_board = Board.new(cell_names)
      computer_board = Board.new(cell_names)
      player_board.place(player_cruiser, ["A2", "A3", "A4"])
      gameplay = GamePlay.new(cell_names, computer_board, player_board)

      gameplay.player_board.cells["A2"].fire_upon
      gameplay.turn_computer_shot

      expected_1 = gameplay.player_board.cells["A1"].fired_upon?
      expected_2 = gameplay.player_board.cells["B2"].fired_upon?
      expected_3 = gameplay.player_board.cells["A3"].fired_upon?

      assert expected_1 || expected_2 || expected_3
    end
  end

  def test_it_can_identify_hit_cells
    generator = CellGenerator.new
    generator.populate_cell_names
    cell_names = generator.cell_names
    player_cruiser = Ship.new("Cruiser", 3)
    player_board = Board.new(cell_names)
    computer_board = Board.new(cell_names)
    player_board.place(player_cruiser, ["A4", "B4", "C4"])
    gameplay = GamePlay.new(cell_names, computer_board, player_board)

    gameplay.player_board.cells["A4"].fire_upon

    assert ["A4"], gameplay.identify_hit_cell

    gameplay.player_board.cells["B4"].fire_upon

    assert ["A4", "B4"], gameplay.identify_hit_cells
  end

  def test_it_can_check_if_cells_are_in_the_same_column
    generator = CellGenerator.new
    generator.populate_cell_names
    cell_names = generator.cell_names
    player_cruiser = Ship.new("Cruiser", 3)
    player_board = Board.new(cell_names)
    computer_board = Board.new(cell_names)
    player_board.place(player_cruiser, ["A4", "B4", "C4"])
    gameplay = GamePlay.new(cell_names, computer_board, player_board)

    gameplay.player_board.cells["A4"].fire_upon
    gameplay.player_board.cells["B4"].fire_upon
    gameplay.identify_hit_cells

    assert true, gameplay.same_column?
  end

  def test_it_can_check_if_cells_are_in_the_same_row
    generator = CellGenerator.new
    generator.populate_cell_names
    cell_names = generator.cell_names
    player_cruiser = Ship.new("Cruiser", 3)
    player_board = Board.new(cell_names)
    computer_board = Board.new(cell_names)
    player_board.place(player_cruiser, ["A2", "A3", "A4"])
    gameplay = GamePlay.new(cell_names, computer_board, player_board)

    gameplay.player_board.cells["A2"].fire_upon
    gameplay.player_board.cells["A3"].fire_upon
    gameplay.identify_hit_cells

    assert true, gameplay.same_row?
  end

  def test_it_removes_invalid_surrounding_cells_corner
    generator = CellGenerator.new
    generator.populate_cell_names
    cell_names = generator.cell_names
    player_cruiser = Ship.new("Cruiser", 3)
    player_board = Board.new(cell_names)
    computer_board = Board.new(cell_names)
    player_board.place(player_cruiser, ["D2", "D3", "D4"])
    gameplay = GamePlay.new(cell_names, computer_board, player_board)

    gameplay.player_board.cells["D4"].fire_upon
    gameplay.identify_hit_cell
    gameplay.map_surrounding_cells

    assert_equal ["D3", "C4"], gameplay.remove_invalid_surrounding_cells
  end

  def test_it_removes_invalid_surrounding_cells_rows
    generator = CellGenerator.new
    generator.populate_cell_names
    cell_names = generator.cell_names
    player_cruiser = Ship.new("Cruiser", 3)
    player_board = Board.new(cell_names)
    computer_board = Board.new(cell_names)
    player_board.place(player_cruiser, ["D2", "D3", "D4"])
    gameplay = GamePlay.new(cell_names, computer_board, player_board)

    gameplay.player_board.cells["D2"].fire_upon
    gameplay.player_board.cells["D3"].fire_upon

    assert true, gameplay.player_board.render.count("H") > 1

    gameplay.identify_hit_cells
    gameplay.map_row_ends

    assert_equal ["D1", "D4"], gameplay.remove_invalid_surrounding_cells
  end

  def test_it_removes_invalid_surrounding_cells_column
    generator = CellGenerator.new
    generator.populate_cell_names
    cell_names = generator.cell_names
    player_cruiser = Ship.new("Cruiser", 3)
    player_board = Board.new(cell_names)
    computer_board = Board.new(cell_names)
    player_board.place(player_cruiser, ["A2", "B2", "C2"])
    gameplay = GamePlay.new(cell_names, computer_board, player_board)

    gameplay.player_board.cells["B2"].fire_upon
    gameplay.player_board.cells["C2"].fire_upon

    assert true, gameplay.player_board.render.count("H") > 1

    gameplay.identify_hit_cells
    gameplay.map_column_ends

    assert_equal ["A2", "D2"], gameplay.remove_invalid_surrounding_cells
    gameplay.player_board.cells["D2"].fire_upon
    gameplay.identify_hit_cells
    gameplay.map_column_ends
    assert_equal ["A2"], gameplay.remove_invalid_surrounding_cells
  end
end
