require 'app/nokia.rb'
require 'app/cat.rb'
require 'app/ground.rb'
require 'app/ground_tile.rb'
require 'app/info_bar.rb'

def tick args
  if args.state.tick_count == 0
    args.state.cat = Cat.new(4, 5)
    args.state.ground_tiles = Array.new(60) { |x| GroundTile.new(x * 16, rand(4)) }
    args.state.ground = Ground.new(args.state.ground_tiles)
    args.state.infobar = InfoBar.new(46, 38)
  end

  if args.state.tick_count % 4 == 0
    args.state.ground.move
  end

  args.state.cat.tick args

  if args.inputs.keyboard.key_down.space && args.state.cat.on_ground
    args.state.cat.jump!
  end

  args.nokia.sprites << args.state.ground
  args.nokia.sprites << args.state.cat
  args.nokia.sprites << args.state.infobar
end

$gtk.reset
