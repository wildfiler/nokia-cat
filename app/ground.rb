class Ground
  attr_reader :offset, :tiles, :tile_offset
  attr_sprite

  def initialize(tiles)
    @tiles = tiles
    @offset = 0
    @tile_offset = 0
  end

  def move
    @offset += 1
    if @offset >= 16
      @tile_offset += 1
      @offset = 0
    end

    if @tile_offset >= tiles.length - 7
      @tile_offset = 0
    end
  end

  def draw_override ffi_draw
    7.times do |i|
      ffi_draw.draw_sprite_3(
        i * 16 - offset, 0, 16, 5,
        "sprites/ground.png",
        0,
        255, 255, 255, 255,
        tiles[tile_offset + i].tile_x, tiles[tile_offset + i].tile_y, 16, 5,
        false, false,
        0, 0,
        0, 0, -1, -1,
      )

      ffi_draw.draw_sprite_3(
        i * 16 - offset, 43, 16, 5,
        "sprites/ceiling.png",
        0,
        255, 255, 255, 255,
        tiles[tile_offset + i].tile_x, tiles[tile_offset + i].tile_y, 16, 5,
        false, false,
        0, 0,
        0, 0, -1, -1,
      )
    end
  end
end
