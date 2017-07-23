require './lib/bitmap'

class BitmapEditor
  attr_accessor :bitmap

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line
      when /I\s(\d+)\s(\d+)/
        @bitmap = create_bitmap($1.to_i, $2.to_i)
      when /H\s(\d+)\s(\d+)\s(\d+)\s([A-Z])/
        color_horizontal_segment($1.to_i, $2.to_i, $3.to_i, $4)
      when "S"
        show
      else
          puts 'unrecognised command :('
      end
    end
  end

  def create_bitmap(width, height)
    @bitmap = Bitmap.new(width, height)
  end

  def show
    @bitmap.render
  end

  def color_horizontal_segment(c1, c2, r, c)
    @bitmap.color_horizontal_segment(c1, c2, r, c)
  end

end
