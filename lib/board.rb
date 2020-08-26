require './lib/cell'

class Board
  attr_reader :cells

  def initialize
    @cell_names = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4",
    "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @cells = Hash[@cell_names.collect {|name| [name, Cell.new(name)]}]
  end

  def valid_coordinate?(key)
    if self.cells.has_key?(key)
      return true
    else
      return false
    end
  end

  def valid_placement?(ship, coordinate_choices)
    if ship.length == coordinate_choices.length
      letters = []
      numbers = []
      coordinate_choices.each do |value|
         letters << value[0]
         numbers << value[1].to_i
      end

      if letters.uniq.count == 1
        consecutive_numbers = []
        (1..4).each_cons(ship.length) do |array|
          consecutive_numbers << array
        end
        if consecutive_numbers.include? numbers
          true
        else
          false
        end
      elsif numbers.uniq.count == 1
        consecutive_letters = []
        ("A".."D").each_cons(ship.length) do |array|
          consecutive_letters << array
        end
        if consecutive_letters.include? letters
          true
        else
          false
        end
      else
        false
      end
    else
      false
    end
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end
end
