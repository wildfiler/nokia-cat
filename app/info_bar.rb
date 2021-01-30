class InfoBar
  attr_sprite

  def initialize(x, y)
    @x = x
    @y = y
  end

  def draw_override(ffi_draw)
    ffi_draw.draw_sprite @x, @y, 37, 9, "sprites/infobar.png"

    ffi_draw.draw_sprite_3(
      @x + 10, @y + 2, 3, 5,
      "fonts/numbers.png",
      0,
      255, 255, 255, 255,
      $gtk.args.state.cat.lives * 3, 0, 3, 5,
      false, false,
      0, 0,
      0, 0, -1, -1
    )

    ffi_draw.draw_sprite_3(
      @x + 30, @y + 2, 3, 5,
      "fonts/numbers.png",
      0,
      255, 255, 255, 255,
      $gtk.args.state.cat.food * 3, 0, 3, 5,
      false, false,
      0, 0,
      0, 0, -1, -1
    )
  end
end
