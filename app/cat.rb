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
    new_x = x + dx
    new_y = y + dy
    passable = map.passable?(new_x, new_y)

    if passable
      @x += dx
      @y += dy

      map.object(x, y)&.events
    end
  end
end
