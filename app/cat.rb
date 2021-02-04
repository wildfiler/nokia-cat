class Cat
  attr_reader :x, :y, :map
  def initialize(x, y, map)
    @x = x
    @y = y
    @map = map
  end

  def tile_x
    0.frame_index(2, 20, true) * 13
  end

  def tile_y
    6 * 13
  end

  def move(dx, dy)
    return if map.collisions(x + dx, y + dy)

    @x += dx
    @y += dy
  end
end
