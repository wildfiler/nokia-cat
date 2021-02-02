class FishingFrame
  attr_sprite

  def draw_override(ffi_draw)
    ffi_draw.draw_sprite_3(
      37, 0, 47, 48,
      "sprites/fishing-frame.png",
      0,
      255, 255, 255, 255,
      0, 0, 47, 48,
      false, false,
      0, 0,
      0, 0, -1, -1,
    )

    ffi_draw.draw_sprite_3(
      0, 0, 37, 48,
      "sprites/fishing-left.png",
      0,
      255, 255, 255, 255,
      37 * 0.frame_index(10, 30, true), 0, 37, 48,
      false, false,
      0, 0,
      0, 0, -1, -1,
    )
  end
end
