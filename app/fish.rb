class Fish
  attr_sprite

  def initialize(x, y)
    @x = x
    @y = y
  end

  def draw_override(ffi_draw)
    ffi_draw.draw_sprite_3(
      x, y, 27, 13,
      "sprites/fish.png",
      0,
      255, 255, 255, 255,
      0, 7, 27, 13,
      false, false,
      0, 0,
      0, 0, -1, -1
    )
  end
end
