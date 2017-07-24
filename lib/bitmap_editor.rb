require './lib/bitmap'

class BitmapEditor
  attr_accessor :bitmap, :error

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line
      when /^I\s(\d+)\s(\d+)$/
        @bitmap = create_bitmap($1.to_i, $2.to_i)
      when /^H\s(\d+)\s(\d+)\s(\d+)\s([A-Z])$/
        color_horizontal_segment($1.to_i, $2.to_i, $3.to_i, $4)
      when /^V\s(\d+)\s(\d+)\s(\d+)\s([A-Z])$/
        color_vertical_segment($1.to_i, $2.to_i, $3.to_i, $4)
      when /^L\s(\d+)\s(\d+)\s([A-Z])$/
        color($1.to_i, $2.to_i, $3)
      when "C"
        clear_grid
      when "S"
        show
      else
          puts 'unrecognised command :('
      end
    end
  end

  def create_bitmap(width, height)
    @bitmap = Bitmap.new(width, height)
    validate_bitmap
    @bitmap
  end

  def show
    validate_bitmap
    @bitmap.render
  end

  def color_horizontal_segment(col1, col2, row, color)
    validate_bitmap
    @bitmap.color_horizontal_segment(col1, col2, row, color)
  end

  def color_vertical_segment(col, row1, row2, color)
    validate_bitmap
    @bitmap.color_vertical_segment(col, row1, row2, color)
  end

  def clear_grid
    validate_bitmap
    @bitmap.clear_grid
  end

  def color(x, y, color)
    validate_bitmap
    @bitmap.color(x, y, color)
  end

  def validate_bitmap
    abort "Create image before issuing commands" if !@bitmap
    abort "Invalid size" if !@bitmap.valid?      
    @bitmap
  end

end
