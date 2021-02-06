require 'app/text.rb'

class Button
  attr_sprite

  def initialize(x, y, w, h, text)
    @x = x
    @y = y
    @w = w
    @h = h
    @text = Text.new(text)
    @pressed = false
  end

  def path
    @path ||= "sprites/button.png"
  end

  def toggle
    @pressed = !@pressed
  end

  def draw_override(ffi_draw)
    tile_dx = @pressed ? 11 : 0
    dx = @pressed ? 1 : 0

    draw_corner(ffi_draw, left + dx, top - 5 - dx, 0 + tile_dx, 0)
    draw_corner(ffi_draw, right - 5 + dx, top - 5 - dx, 6 + tile_dx, 0)
    draw_corner(ffi_draw, left + dx, bottom - dx, 0 + tile_dx, 6)
    draw_corner(ffi_draw, right - 5 + dx, bottom - dx, 6 + tile_dx, 6)
    draw_vertical_line(ffi_draw, left + dx, bottom + 5 - dx, 0 + tile_dx, 5, h - 10)
    draw_vertical_line(ffi_draw, right - 5 + dx, bottom + 5 - dx, 6 + tile_dx, 5, h - 10)
    draw_horizontal_line(ffi_draw, left + 5 + dx, top - 5 - dx, 6 + tile_dx, 0, w - 10)
    draw_horizontal_line(ffi_draw, left + 5 + dx, bottom - dx, 6 + tile_dx, 6, w - 10)
    ffi_draw.draw_solid(left + 5 + dx, bottom + 5 - dx, w - 10, h - 10, 199, 240, 216, 255)

    @text.draw(ffi_draw, left + 3 + dx, bottom + 3 - dx)
  end

  def draw_horizontal_line(ffi_draw, x, y, tile_x, tile_y, w)
    ffi_draw.draw_sprite_3(
      x, y, w, 5,
      path,
      0,
      255, 255, 255, 255,
      tile_x, tile_y, 1, 5,
      false, false,
      0, 0,
      0, 0, -1, -1,
    )
  end

  def draw_vertical_line(ffi_draw, x, y, tile_x, tile_y, h)
    ffi_draw.draw_sprite_3(
      x, y, 5, h,
      path,
      0,
      255, 255, 255, 255,
      tile_x, tile_y, 5, 1,
      false, false,
      0, 0,
      0, 0, -1, -1,
    )
  end

  def draw_corner(ffi_draw, x, y, tile_x, tile_y)
    ffi_draw.draw_sprite_3(
      x, y, 5, 5,
      path,
      0,
      255, 255, 255, 255,
      tile_x, tile_y, 5, 5,
      false, false,
      0, 0,
      0, 0, -1, -1,
    )
  end
end
