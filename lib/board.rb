require './lib/cell'

class Board
  attr_reader :coordinates

  def initialize
    @cell_names = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4",
    "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @coordinates = {}
  end

  def cells
    @coordinates = Hash[@cell_names.collect do |name|
      [name, Cell.new(name)]
    end]
    # p coordinates
  end

  def valid_coordinate?(key)
    if self.coordinates.has_key?(key)
      return true
    else
      return false
    end
  end
end
