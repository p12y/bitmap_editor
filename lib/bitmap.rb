
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

  def color_horizontal_segment(**keyword_args)
    keyword_args[:coords].each do |k, v|
      instance_variable_set "@#{k}", v - 1
    end
    check_in_bounds(cols: [@col1, @col2], row: @row)
    row = @array[@row]
    row[@col1..@col2] = row[@col1..@col2].map {|char| char = keyword_args[:color]}
  end

  def color_vertical_segment(**keyword_args)
    keyword_args[:coords].each do |k, v|
      instance_variable_set "@#{k}", v - 1
    end
    check_in_bounds(col: @col + 1, rows: [@row1 + 1, @row2 + 1])
    @array.slice(@row1, @row2).each do |arr|
      arr[@col] = keyword_args[:color]
    end
  end

  def clear_grid
    @array.each do |arr|
      arr.map! {|c| c = "O"}
    end
  end

  def color(**keyword_args)
    keyword_args[:coords].each do |k, v|
      instance_variable_set "@#{k}", v - 1
    end
    check_in_bounds(col: @col + 1, row: @row + 1)
    @array[@row][@col] = keyword_args[:color]
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