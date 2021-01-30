class GroundTile
  attr_sprite

  attr_reader :type

  def initialize(x, type = 0)
    @x = x
    @y = 0
    @w = 16
    @h = 5
    @tile_y = 0
    @type = type
  end

  def tile_x
    type * w
  end

  def draw_override ffi_draw
    ffi_draw.draw_sprite_3(
      x, y, w, h,
      "sprites/ground.png",
      angle,
      a, r, g, b,
      tile_x, tile_y, w, h,
      !!flip_horizontally, !!flip_vertically,
      angle_anchor_x, angle_anchor_y,
      source_x, source_y, source_w, source_h,
    )
  end
end
