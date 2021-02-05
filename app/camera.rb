class Camera
  attr_sprite
  attr_reader :map
  attr_accessor :x, :y, :cat

  def initialize(x, y)
    @x = x
    @y = y
  end

  def draw_override(ffi_draw)
    start_x = (object_x - 3).clamp(0, map.width - 7)
    start_y = (object_y - 1).clamp(0, map.height - 4)
    start_x.upto(start_x+7) do |x|
      start_y.upto(start_y+4) do |y|
        screen_x = x - start_x
        screen_y = y - start_y

        ground_tile = map.ground(x, y)
        object_tile = map.object(x, y)

        draw_sprite(ffi_draw, ground_tile, screen_x, screen_y) if ground_tile
        draw_sprite(ffi_draw, object_tile, screen_x, screen_y) if object_tile
      end
    end

    draw_sprite(ffi_draw, cat, cat.x - start_x, cat.y - start_y, flip: cat.flip)
  end

  def draw_sprite(ffi_draw, tile, screen_x, screen_y, flip: false)
    ffi_draw.draw_sprite_3(
      (screen_x) * 13, screen_y * 13, 13, 13,
      "sprites/forest.png",
      0,
      255, 255, 255, 255,
      tile.tile_x, tile.tile_y, 13, 13,
      flip, false,
      0, 0,
      0, 0, -1, -1,
    )
  end

  def map=(map)
    @map = map
  end

  def follow(object)
    @object = object
  end

  def object_x
    @object&.x || @x
  end

  def object_y
    @object&.y || @y
  end

  def x=(new_x)
    @x = new_x.clamp(4, 16)
  end

  def y=(new_y)
    @y = new_y.clamp(2, 18)
  end
end
