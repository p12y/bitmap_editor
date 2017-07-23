
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

end