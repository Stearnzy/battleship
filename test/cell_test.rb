require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists

    assert_instance_of Cell, @cell
  end

  def test_it_has_readable_attributes

    assert_equal "B4", @cell.coordinate
    assert_equal nil, @cell.ship
    assert_equal true, @cell.empty
    assert_equal false, @cell.fired_upon
  end

  def test_if_it_can_place_ship_into_cell

    assert_equal nil, @cell.ship

    @cell.place_ship(@cruiser)

    assert_equal @cruiser, @cell.ship
  end

  def test_if_it_is_empty

    assert_equal true, @cell.empty?

    @cell.place_ship(@cruiser)

    assert_equal false, @cell.empty?
  end

  def test_it_can_be_fired_upon

    assert_equal false, @cell.fired_upon?
    assert_equal 3, @cell.ship.health

    @cell.fire_upon

    assert_equal true, @cell.fired_upon?
    assert_equal 2, @cell.ship.health
  end

end
