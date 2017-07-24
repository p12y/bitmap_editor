
class Bitmap
  attr_reader :array

  def initialize(width, length)
    @width = width
    @length = length
    @array = Array.new(length) { Array.new(width, "O") }
  end

  def length
    @length
  end

  def width
    @width
  end

  def valid?
    (1..250).include?(@width) && (1..250).include?(@length)
  end

  def render
    @array.each do |arr|
      puts arr.join
    end
  end

  def color_horizontal_segment(col1, col2, row, color)
    check_in_bounds(cols: [col1, col2], row: row)
    @r = row - 1; @c1 = col1 - 1; @c2 = col2 - 1
    row = @array[@r]
    row[@c1..@c2] = row[@c1..@c2].map {|char| char = color}
  end

  def color_vertical_segment(col, row1, row2, color)
    check_in_bounds(col: col, rows: [row1, row2])
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

  def color(x, y, color)
    check_in_bounds(col: x, row: y)
    @x = x - 1; @y = y - 1
    @array[@y][@x] = color
  end

  def check_in_bounds(**keyword_arguments)
    keyword_arguments.each do |k, v|
      case k
      when :col
        validate_coord(v, @width, :column)
      when :row
        validate_coord(v, @length, :row)
      when :cols
        keyword_arguments[:cols].each do |col|
          validate_coord(col, @width, :column)
        end
      when :rows
        keyword_arguments[:rows].each do |row|
          validate_coord(row, @length, :row)
        end
      end
    end
  end

  def validate_coord(coord, dimension, type)
    if !(1..dimension).include?(coord)
      abort "#{type.to_s.capitalize} coordinates must be between 1 and #{dimension}"
    end
  end



end