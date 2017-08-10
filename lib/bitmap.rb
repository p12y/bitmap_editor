
class Bitmap
  def initialize(width, length)
    @width = width
    @length = length
    @DEFAULT_COLOR = 'O'
    @array = Array.new(length) { Array.new(width, @DEFAULT_COLOR) }
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

  def fill(col, row, color, color_to_replace = nil)
    color_to_replace = @array[row - 1][col - 1] if color_to_replace.nil?
    current_color = @array[row - 1][col - 1]
    
    return if color_to_replace != current_color

    if col < width
      fill(col + 1, row, color, color_to_replace)  
    end

    if col > 1
      fill(col - 1, row, color, color_to_replace)
    end
    @array[row - 1][col - 1] = color
  end

  def color_horizontal_segment(**args)
    set_vars(args)
    check_in_bounds(cols: [@col1, @col2], row: @row)
    row = @array[@row]
    row[@col1..@col2] = row[@col1..@col2].map {|char| char = @color}
  end

  def color_vertical_segment(**args)
    set_vars(args)
    check_in_bounds(col: @col, rows: [@row1, @row2])
    @array.slice(@row1, @row2).each do |arr|
      arr[@col] = @color
    end
  end

  def clear_grid
    @array.each do |arr|
      arr.map! {|c| c = @DEFAULT_COLOR}
    end
  end

  def color(**args)
    set_vars(args)
    check_in_bounds(col: @col, row: @row)
    @array[@row][@col] = @color
  end

  private

    def set_vars(args)
      @color = args[:color]
      args[:coords].each do |k, v|
        instance_variable_set "@#{k}", v - 1
      end
    end

    def check_in_bounds(**args)
      args.each do |k, v|
        case k
        when :col
          validate_coord(v, @width, :column)
        when :row
          validate_coord(v, @length, :row)
        when :cols
          args[:cols].each do |col|
            validate_coord(col, @width, :column)
          end
        when :rows
          args[:rows].each do |row|
            validate_coord(row, @length, :row)
          end
        end
      end
    end

    def validate_coord(coord, dimension, type)
      if !(1..dimension).include?(coord + 1)
        abort "#{type.to_s.capitalize} coordinates must be between 1 and #{dimension}"
      end
    end

end