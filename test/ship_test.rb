require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def test_it_exists
    ship = Ship.new("Cruiser", 3)
    assert_instance_of Ship, ship
  end

  def test_ship_has_a_name
    ship = Ship.new("Cruiser", 3)
    assert_equal "Cruiser", ship.name
    ship = Ship.new("Submarine", 2)
    assert_equal "Submarine", ship.name
  end

  def test_ship_starts_with_health
    ship = Ship.new("Cruiser", 3)
    assert_equal 3, ship.health
    ship = Ship.new("Submarine", 2)
    assert_equal 2, ship.health
  end

  def test_ship_starts_floating
    ship = Ship.new("Submarine", 2)
    refute ship.sunk?
  end

  def test_ship_can_take_damage
    ship = Ship.new("Submarine", 2)
    ship.hit
    assert_equal 1, ship.health
  end

  def test_ship_can_be_destroyed
    ship = Ship.new("Cruiser", 3)
    assert_equal 3, ship.health
    ship.hit
    assert_equal 2, ship.health
    refute ship.sunk?
    ship.hit
    refute ship.sunk?
    ship.hit
    assert ship.sunk?
  end
end