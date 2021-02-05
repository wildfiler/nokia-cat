class Bubble
  attr_sprite

  def initialize(x, y, type, min_x, max_x)
    @type = type
    @x = x
    @y = y
    @w = 6
    @h = 6
    @tile_x = type == :small ? 0 : 6
    @min_x = min_x
    @max_x = max_x
  end

  def draw_override(ffi_draw)
    ffi_draw.draw_sprite_3(
      x, y, 6, 6,
      "sprites/bubbles.png",
      0,
      255, 255, 255, 255,
      tile_x, 0, 6, 6,
      false, false,
      0, 0,
      0, 0, -1, -1,
    )
  end

  def move
    self.y += 1 if rand > 0.1
    self.x += 1.rand_sign if rand > 0.7
  end

  def x=(new_x)
    @x = new_x.clamp(@min_x, @max_x)
  end
end
