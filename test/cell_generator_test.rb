require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell_generator.rb'

class CellGeneratorTest < Minitest::Test
  def test_it_can_populate_cell_names
    names = CellGenerator.new(5, 5)
    names_2 = CellGenerator.new(10, 3)
    names_3 = CellGenerator.new(7, 8)

    require 'pry'; binding.pry
  end
end
