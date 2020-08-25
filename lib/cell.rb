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
    if self.empty?
      @cell_status = "M"
    # maybe add elsif later to account for shooting on a coordinate that has already been shot at
    else
      @cell_status = "H"
    end
  end

  def render(boolean = false)
    if boolean == true
      @cell_status = "S"
  end
end
