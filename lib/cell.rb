class Cell
  attr_reader :coordinate, :ship, :cell_status

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
    @cell_status = "."
  end

  def empty?
    if @ship == nil
      return true
    elsif @ship != nil
      return false
    end
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

  def render(boolean = false)
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
        if boolean == true
          cell_status = "S"
        elsif boolean == true && ship.sunk? == true
          cell_status = "X"
        else
          cell_status = "."
        end
      end
    end
  end
end
