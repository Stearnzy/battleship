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
    assert_equal 2, cell.ship.health
  end

  def test_it_can_render_a_miss
    cell_1 = Cell.new("B4")

    assert_equal ".", cell_1.render

    cell_1.fire_upon

    assert_equal "M", cell_1.render
  end

  def test_it_can_render_a_hit
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)

    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)

    cell_2.fire_upon
    assert_equal "H", cell_2.render
    assert_equal "H", cell_2.render(true)
  end

  def test_cell_can_render_sunken_ship
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)

    assert_equal false, cruiser.sunk?

    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
    cell_2.fire_upon
    assert_equal "H", cell_2.render
    assert_equal "H", cell_2.render(true)
    assert_equal false, cruiser.sunk?

    cell_2.fire_upon
    cell_2.fire_upon

    assert cruiser.sunk?
    assert_equal "X", cell_2.render
    assert_equal "X", cell_2.render(true)
  end

end
