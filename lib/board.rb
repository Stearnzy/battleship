require './lib/cell'

class Board
  attr_reader :cells, :cell_names

  def initialize
    @cell_names = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4",
    "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @cells = Hash[@cell_names.collect {|name| [name, Cell.new(name)]}]
  end

  def valid_coordinate?(key)
    cells.has_key?(key)
  end

  def valid_placement?(ship, coordinate_choices)
    # needs check to see if coordinates exist on board
    if coordinates_are_empty?(coordinate_choices)
      if ship.length == coordinate_choices.length
        generate_row_and_column_arrays(coordinate_choices)
        if all_on_one_row?
          consecutive_numbers?(ship)
        elsif all_on_one_column?
          consecutive_letters?(ship)
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

  def coordinates_are_empty?(coordinate_choices)
    empty_coordinates = coordinate_choices.map do |coordinate|
      @cells[coordinate].empty?
    end
    empty_coordinates.all?
  end

  def generate_row_and_column_arrays(coordinate_choices)
    @row_letters = []
    @column_numbers = []
    coordinate_choices.each do |value|
       @row_letters << value[0]
       @column_numbers << value[1].to_i
    end
  end

  def all_on_one_row?
    @row_letters.uniq.count == 1
  end

  def consecutive_numbers?(ship)
    consecutive_numbers = []
    (1..4).each_cons(ship.length) do |array|
      consecutive_numbers << array
    end
    consecutive_numbers.include? @column_numbers
  end

  def all_on_one_column?
    @column_numbers.uniq.count == 1
  end

  def consecutive_letters?(ship)
    consecutive_letters = []
    ("A".."D").each_cons(ship.length) do |array|
      consecutive_letters << array
    end
    consecutive_letters.include? @row_letters
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def render(player_board = false)
    final_string = []
    final_string << "  1 2 3 4 \n"
    rows = @cell_names.each_slice(4).to_a
    rows.each do |individual_row|
      final_string << ((individual_row[0])[0] + " ")
      individual_row.each do |cell|
        final_string << @cells[cell].render(player_board) + " "
      end
      final_string << "\n"
    end
    final_string.join
  end
end
