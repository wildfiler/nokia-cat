class Cat
  attr_sprite

  attr_accessor :lives, :food

  def initialize(x, y)
    @x = x
    @y = y
    @w = 16
    @h = 16
    @tile_y = 0
    @jump = false
    @fall = false
    @lives = 0
    @food = 0
  end

  def on_ground
    !@jump && !@fall
  end

  def tile_x
    0.frame_index(4, 10, true) * 16
  end

  def draw_override ffi_draw
    ffi_draw.draw_sprite_3(
      x, y, w, h,
      "sprites/cat2.png",
      angle,
      a, r, g, b,
      tile_x, tile_y, 16, 16,
      !!flip_horizontally, !!flip_vertically,
      angle_anchor_x, angle_anchor_y,
      source_x, source_y, source_w, source_h,
    )
  end

  def jump!
    @jump = true
  end

  def tick args
    if @jump
      @y += 1
      if @y >= 30
        @jump = false
        @fall = true
      end
    end

    if @fall
      @y -= 1

      if @y <= 5
        @fall = false
      end
    end
  end
end
