require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell_generator.rb'

class CellGeneratorTest < Minitest::Test

  def test_it_exists
    generator = CellGenerator.new

    assert_instance_of CellGenerator, generator
  end

  def test_it_has_readable_attributes
    generator = CellGenerator.new(3, 4)

    assert_equal 3, generator.height
    assert_equal 4, generator.width
    assert_equal [], generator.cell_names
  end

  def test_it_defaults_to_four_by_four
    generator = CellGenerator.new

    assert_equal 4, generator.height
    assert_equal 4, generator.width
  end

  def test_it_can_populate_cell_names_when_height_equals_width
    generator_1 = CellGenerator.new(2, 2)
    generator_2 = CellGenerator.new(5, 5)
    generator_1.populate_cell_names
    generator_2.populate_cell_names

    expected = ["A1", "A2", "A3", "A4", "A5", "B1", "B2", "B3", "B4", "B5", "C1", "C2", "C3", "C4", "C5", "D1", "D2", "D3", "D4", "D5", "E1", "E2", "E3", "E4", "E5"]

    assert_equal ["A1", "A2", "B1", "B2"], generator_1.cell_names
    assert_equal expected, generator_2.cell_names
  end

  def test_it_can_populate_cell_names_when_height_exceeds_width
    generator = CellGenerator.new(1, 9)
    generator.populate_cell_names

    expected = ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9"]

    assert_equal expected, generator.cell_names
  end

  def test_it_can_populate_cell_names_when_width_exceeds_height
    generator = CellGenerator.new(9, 1)
    generator.populate_cell_names

    expected = ["A1", "B1", "C1", "D1", "E1", "F1", "G1", "H1", "I1"]

    assert_equal expected, generator.cell_names
  end
end
