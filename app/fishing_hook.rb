class FishingHook
  attr_sprite

  def initialize(y, min_y, max_y)
    @y = y
    @min_y = min_y
    @max_y = max_y

    @h_h = 10
  end

  def y=(new_y)
    @y = new_y.clamp(@min_y, @max_y)
  end

  def h
    42 - y
  end

  def h_y
    5 + y
  end

  def body_rect
    [0, h_y, 10, @h_h]
  end

  def draw_override(ffi_draw)
    ffi_draw.draw_sprite_3(
      45, h_y, 8, h,
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
