
class Bitmap
  attr_reader :array

  def initialize(width, length)
    @width = width
    @length = length
    @array = Array.new(length) { Array.new(width, "O") }
  end

  def length
    @array.length
  end

  def width
    @array[1].length
  end

  def render
    @array.each do |arr|
      puts arr.join
    end
  end

  def color_horizontal_segment(col1, col2, row, color)
    @r = row - 1; @c1 = col1 - 1; @c2 = col2 - 1
    row = @array[@r]
    row[@c1..@c2] = row[@c1..@c2].map {|char| char = color}
  end

  def color_vertical_segment(col, row1, row2, color)
    @col = col - 1; @row1 = row1 - 1; @row2 = row2 - 1
    @array.slice(@row1, @row2).each do |arr|
      arr[@col] = color
    end
  end

  def clear_grid
    @array.each do |arr|
      arr.map! {|c| c = "O"}
    end
  end

end