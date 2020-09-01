require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/cell_generator'
require './lib/game_setup'

class GameSetupTest < Minitest::Test
  def test_it_exists
    setup = GameSetup.new

    assert_instance_of GameSetup, setup
  end

  def test_it_can_validate_height
    setup = GameSetup.new

    assert setup.valid_height?(2)
    assert setup.valid_height?(9)
    assert_equal false, setup.valid_height?("?")
    assert_equal false, setup.valid_height?(400)
  end

  def test_it_can_validate_width
    setup = GameSetup.new

    assert setup.valid_width?(1)
    assert setup.valid_width?(7)
    assert_equal false, setup.valid_width?("|")
    assert_equal false, setup.valid_width?(-25)
  end

  def test_it_can_randomly_choose_comp_cruiser_cells
    setup = GameSetup.new
    generator = CellGenerator.new
    generator.populate_cell_names
    cell_names = generator.cell_names
    random_cells_1 = setup.randomize_computer_cruiser_cells(cell_names)
    random_cells_2 = setup.randomize_computer_cruiser_cells(cell_names)

    refute_equal random_cells_1, random_cells_2
  end

end