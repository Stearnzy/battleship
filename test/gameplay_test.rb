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
    gameplay.turn_computer_shot

    assert_equal true, gameplay.computer_won?
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
end
