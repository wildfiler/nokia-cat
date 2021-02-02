class FishingHook
  attr_sprite

  def initialize(y)
    @y = y

    @h_h = 10
  end

  def h
    42 - y
  end

  def h_y
    5 + y
  end

  def draw_override(ffi_draw)
    ffi_draw.draw_sprite_3(
      45, 4 + y, 8, h,
      "sprites/fishing-hook.png",
      0,
      255, 255, 255, 255,
      nil, nil, nil, nil,
      false, false,
      0, 0,
      0, 0, 8, h,
    )

    ffi_draw.draw_line(
      42, h_y, 42, h_y + @h_h, 67, 82, 61, 255,
    )
  end
end
