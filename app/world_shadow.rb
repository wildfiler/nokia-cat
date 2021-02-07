class WorldShadow
  attr_sprite
  attr_reader :map, :cat, :world_clock

  def initialize(world_clock, map, cat)
    @world_clock = world_clock
    @map = map
    @cat = cat
  end

  def draw_override(ffi_draw)
    sun_frame = world_clock.hour

    frame = if sun_frame < 3
      sun_frame
    elsif sun_frame >= 19
      0
    elsif sun_frame > 15
      18 - sun_frame
    else
      nil
    end

    if frame
      start_x = (cat.x - 3).clamp(0, map.width - 7)
      start_y = (cat.y - 1).clamp(0, map.height - 4)

      ffi_draw.draw_sprite_3(
        (cat.x - start_x - 7) * 13, (cat.y - start_y - 3) * 13, 195, 91,
        "sprites/shadow.png",
        0,
        255, 255, 255, 255,
        frame * 195, 0, 13 * 15, 13 * 7,
        false, false,
        0, 0,
        0, 0, -1, -1,
      )
    end
  end
end
