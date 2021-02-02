class Weed
  attr_sprite

  def initialize(x, y, type)
    @x = x
    @y = y
    @type = type
  end

  def tile_x
    9 * 0.frame_index(10, 20, true)
  end

  def tile_y
    @type * 13
  end

  def draw_override(ffi_draw)
    ffi_draw.draw_sprite_3(
      x, y, 9, 13,
      "sprites/fishing-weeds.png",
      0,
      255, 255, 255, 255,
      tile_x, tile_y, 9, 13,
      false, false,
      0, 0,
      0, 0, -1, -1,
    )
  end
end
