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
  # When do we use instance variables??
      ship.hit
    end
  end

  def render(boolean = false)
    if boolean == true
      if fired_upon?
        if empty?
          cell_status = "M"
        else
          cell_status = "H"
        end
      else
        if empty?
          cell_status = "."
        else
          cell_status = "S"
        end
      end
    else
      if fired_upon?
        if empty?
          cell_status = "M"
        else
          cell_status = "H"
        end
      else
        cell_status = "."
      end
    end
  end

  def renderooni(boolean = false)
    if fired_upon?
      if empty?
        cell_status = "M"
      else
        cell_status = "H"
      end
    else
      if empty?
        cell_status = "."
      else
        if boolean == true
          cell_status = "S"
        else
          cell_status = "."
        end
      end
    end
  end
end
