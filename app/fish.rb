class Fish
  attr_sprite
  attr_reader :fish_type

  STATS = [
    {
      speed: 2,
      mobility: 0.4,
      height: 13,
      vertical_stability:  6,
    },
    {
      speed: 3,
      mobility: 0.5,
      height: 9,
      vertical_stability:  3,
    },
    {
      speed: 2,
      mobility: 0.4,
      height: 12,
      vertical_stability:  9,
    },
    {
      speed: 1,
      mobility: 0.5,
      height: 9,
      vertical_stability:  6,
    },
  ]

  def initialize(x, y, fish_type)
    @x = x
    @y = y
    @fish_type = fish_type
    @stay = 0
    @move = 0
    @direction = 0
  end

  def draw_override(ffi_draw)
    ffi_draw.draw_sprite_3(
      x, y, 31, 20,
      "sprites/fish.png",
      0,
      255, 255, 255, 255,
      0.frame_index(10, 20, true) * 31, fish_type * 20, 31, 20,
      false, false,
      0, 0,
      0, 0, -1, -1
    )
  end

  def move
    if @stay > 0
      @stay -= 1
      self.y += 1.rand_sign
    elsif @move > 0
      @move -= 1
      self.y += speed * @direction
    else
      @stay = vertical_stability
      @move = height
      @direction = y > 20 ? -1 : 1
    end

    self.x += speed.rand_sign if rand <= mobility

    self.y = y.clamp(5, 35)
    self.x = x.clamp(50, 65)
  end

  def body_rect
    [0, y, 10, height]
  end

  def speed
    @speed ||= STATS[fish_type][:speed]
  end

  def mobility
    @mobility ||= STATS[fish_type][:mobility]
  end

  def height
    @height ||= STATS[fish_type][:height]
  end

  def vertical_stability
    @vertical_stability ||= STATS[fish_type][:vertical_stability]
  end
end
