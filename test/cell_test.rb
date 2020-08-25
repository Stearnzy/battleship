require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def test_it_exists
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    assert_instance_of Cell, cell
  end

  def test_it_has_readable_attributes
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    assert_equal "B4", cell.coordinate
    assert_nil cell.ship
  end

  def test_if_it_can_place_ship_into_cell
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    assert_nil cell.ship
    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship
  end

  def test_if_it_is_empty
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    assert_equal true, cell.empty?

    cell.place_ship(cruiser)
    assert_equal false, cell.empty?
  end

  def test_it_can_be_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    assert_equal false, cell.fired_upon?
    assert_equal 3, cell.ship.health

    cell.fire_upon

    assert_equal true, cell.fired_upon?
    cell.ship.hit
    assert_equal 2, cell.ship.health
  end

end
