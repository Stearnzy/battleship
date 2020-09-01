require './lib/cell'

class Board
  attr_reader :cells, :cell_names, :height, :width

  def initialize(cell_names, height = 4, width = 4)
    @cell_names = cell_names
    @height = height
    @width = width
    @cells = Hash[@cell_names.collect {|name| [name, Cell.new(name)]}]
  end

  def valid_coordinate?(key)
    cells.has_key?(key)
  end

  def valid_placement?(ship, coordinate_choices)
    if coordinates_exist_on_board?(coordinate_choices)
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
    else
      false
    end
  end

  def coordinates_exist_on_board?(coordinate_choices)
    valid_choices = true
    coordinate_choices.each do |coordinate_choice|
      if !@cell_names.include? coordinate_choice
        valid_choices = false
      end
    end
    valid_choices
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
    (1..@width).each_cons(ship.length) do |array|
      consecutive_numbers << array
    end
    consecutive_numbers.include? @column_numbers
  end

  def all_on_one_column?
    @column_numbers.uniq.count == 1
  end

  def consecutive_letters?(ship)
    consecutive_letters = []
    ("A"..(@height + 64).chr).each_cons(ship.length) do |array|
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
    board_lines = []
    column_numbers = @width.downto(1).to_a.reverse
    board_lines << "  "
    column_numbers.each do |column_number|
      board_lines << "#{column_number} "
    end
    board_lines << "\n"
    rows = @cell_names.each_slice(@width).to_a
    rows.each do |individual_row|
      board_lines << ((individual_row[0])[0] + " ")
      individual_row.each do |cell|
        board_lines << @cells[cell].render(player_board) + " "
      end
      board_lines << "\n"
    end
    board_lines.join
  end
end
