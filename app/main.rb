require 'app/nokia.rb'

class GroundTile
  attr_sprite

  attr_reader :type

  def initialize(x, type = 0)
    @x = x
    @y = 0
    @w = 16
    @h = 5
    @tile_y = 0
    @type = type
  end

  def tile_x
    type * w
  end

  def draw_override ffi_draw
    ffi_draw.draw_sprite_3(
      x, y, w, h,
      "sprites/ground.png",
      angle,
      a, r, g, b,
      tile_x, tile_y, w, h,
      !!flip_horizontally, !!flip_vertically,
      angle_anchor_x, angle_anchor_y,
      source_x, source_y, source_w, source_h,
    )
  end
end

class Cat
  attr_sprite

  def initialize(x, y)
    @x = x
    @y = y
    @w = 16
    @h = 16
    @tile_y = 0
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
end

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

    if @tile_offset >= tiles.length
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
    end
  end
end

def tick args
  args.state.cat ||= Cat.new(4, 5)
  args.state.ground_tiles ||= Array.new(60) { |x| GroundTile.new(x * 16, rand(3)) }
  args.state.ground ||= Ground.new(args.state.ground_tiles)

  if args.state.tick_count % 4 == 0
    args.state.ground.move
  end

  args.nokia.sprites << args.state.cat
  args.nokia.sprites << args.state.ground
end

$gtk.reset
