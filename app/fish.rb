class Fish
  attr_sprite
  attr_reader :fish_type

  def initialize(x, y, fish_type)
    @x = x
    @y = y
    @fish_type = fish_type
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
end
