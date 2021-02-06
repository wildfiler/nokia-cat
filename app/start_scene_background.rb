class StartSceneBackground
  attr_sprite

  def draw_override(ffi_draw)
    ffi_draw.draw_sprite_3(
      0, 0, 84, 48,
      "sprites/start-screen.png",
      0,
      255, 255, 255, 255,
      0.frame_index(10, 20, true) * 84, 0, 84, 48,
      false, false,
      0, 0,
      0, 0, -1, -1,
    )
  end
end
