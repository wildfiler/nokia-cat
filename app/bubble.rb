class Bubble
  attr_sprite

  def initialize(x, y, type)
    @type = type
    @x = x
    @y = y
    @w = 6
    @h = 6
    @tile_x = type == :small ? 0 : 6
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
end
