require 'app/nokia.rb'
require 'app/cat.rb'
require 'app/ground.rb'
require 'app/ground_tile.rb'
require 'app/info_bar.rb'

class Cactus
  attr_sprite

  def initialize(x, y)
    @x = x
    @y = y
  end

  def move
    @x -= 1
  end

  def visible?
    @x > -16
  end

  def draw_override ffi_draw
    ffi_draw.draw_sprite_3(
      x, y, 16, 16,
      "sprites/cactus.png",
      0,
      255, 255, 255, 255,
      0, 0, 16, 16,
      false, false,
      0, 0,
      0, 0, -1, -1,
    )
  end
end

def tick args
  if args.state.tick_count == 0
    args.state.cat = Cat.new(4, 5)
    args.state.ground_tiles = Array.new(60) { |x| GroundTile.new(x * 16, rand(4)) }
    args.state.ground = Ground.new(args.state.ground_tiles)
    args.state.infobar = InfoBar.new(46, 38)
    args.state.cactuses = [Cactus.new(64, 5)]
    args.state.speed = 5
  end

  if args.state.tick_count % 12 == 0
    args.state.speed.times do
      args.state.ground.move
      args.state.cactuses.each(&:move)
    end
    args.state.cactuses.delete_if { |cactus| !cactus.visible? }
  end

  if args.state.tick_count.zmod?(16 * 4) && rand(2) == 0
    args.state.cactuses.push(Cactus.new(84, 5))
  end

  args.state.cat.tick args

  if args.inputs.keyboard.key_down.up
    args.state.speed += 1
  end

  if args.inputs.keyboard.key_down.down
    args.state.speed -= 1
  end

  if args.inputs.keyboard.key_down.space && args.state.cat.on_ground
    args.state.cat.jump!
  end

  args.nokia.sprites << args.state.ground
  args.nokia.sprites << args.state.cactuses
  args.nokia.sprites << args.state.cat
  args.nokia.sprites << args.state.infobar

  $gtk.args.outputs.labels << { x: 8, y: 720 - 28, text: "#{$gtk.args.gtk.current_framerate}fps", r: 255}
  $gtk.args.outputs.labels << { x: 8, y: 720 - 56, text: "#{    args.state.speed }", r: 255}
end

$gtk.reset
