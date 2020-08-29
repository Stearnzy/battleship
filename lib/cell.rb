class Cell
  attr_reader :coordinate, :ship, :cell_status

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
    @cell_status = "."
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if empty? == false
      ship.hit
    end
  end

  def render(player_board = false)
    if fired_upon?
      if empty?
        cell_status = "M"
      elsif ship.sunk?
        cell_status = "X"
      else
        cell_status = "H"
      end
    else
      if empty?
        cell_status = "."
      else
        if player_board == true
          cell_status = "S"
        elsif player_board == true && ship.sunk? == true
          cell_status = "X"
        else
          cell_status = "."
        end
      end
    end
  end
end
