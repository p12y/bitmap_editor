
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

  def color_horizontal_segment(c1, c2, r, c)
    @r = r - 1; @c1 = c1 - 1; @c2 = c2 - 1
    row = @array[@r]
    row[@c1..@c2] = row[@c1..@c2].map {|char| char = c}
  end

end