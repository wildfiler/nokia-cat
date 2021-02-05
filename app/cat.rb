class Cat
  attr_reader :x, :y, :map, :flip
  def initialize(x, y, map)
    @x = x
    @y = y
    @map = map
    @flip = true
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

      if dx.positive?
        @flip = true
      elsif dx.negative?
        @flip = false
      end

      map.object(x, y)&.events
    end
  end
end
