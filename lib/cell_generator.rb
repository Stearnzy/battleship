class CellGenerator
  attr_reader :height, :width, :cell_names

  def initialize(height = 4, width = 4)
    @height = height
    @width = width
    @cell_names = []
  end

  def populate_cell_names
    height.times do |height_count|
      ordinal_height = 65 + height_count
      width.times do |width_count|
        @cell_names << "#{ordinal_height.chr}" + "#{(width_count + 1)}"
      end
    end
  end
end
