class Sun
  attr_sprite

  attr_reader :world_clock

  def initialize(world_clock)
    @world_clock = world_clock
  end

  def draw_override(ffi_draw)
    ffi_draw.draw_sprite_3(
      84 - 25, 48 - 20, 25, 20,
      "sprites/sun.png",
      0,
      255, 255, 255, 255,
      world_clock.hour * 25, 0, 25, 20,
      false, false,
      0, 0,
      0, 0, -1, -1,
    )
  end
end
