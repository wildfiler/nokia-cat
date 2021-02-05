class FinishedFishingSprite
  attr_sprite
  attr_reader :type, :fish_type

  def initialize(type, fish_type)
    @type = type
    @fish_type = fish_type
    @start_at = Kernel.tick_count
  end

  def cat_tile_y
    cat_tile_y ||= case type
    when :success
      39
    else
      0
    end
  end

  def draw_override ffi_draw
    ffi_draw.draw_sprite_3(
      0, 0, 84, 48,
      "sprites/fishing-grass-finished.png",
      0,
      255, 255, 255, 255,
      nil, nil, nil, nil,
      false, false,
      0, 0,
      0, 0, -1, -1
    )

    ffi_draw.draw_sprite_3(
      15, 1, 54, 39,
      "sprites/fishing-finished-cat.png",
      0,
      255, 255, 255, 255,
      @start_at.frame_index(10, 20, true) * 54, cat_tile_y, 54, 39,
      false, false,
      0, 0,
      0, 0, -1, -1
    )

    if type == :success
      ffi_draw.draw_sprite_3(
        50, 5, 31, 20,
        "sprites/fish.png",
        0,
        255, 255, 255, 255,
        @start_at.frame_index(10, 20, true) * 31, fish_type * 20, 31, 20,
        false, false,
        0, 0,
        0, 0, -1, -1
      )
    end
  end
end
