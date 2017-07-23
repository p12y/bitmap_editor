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

end
