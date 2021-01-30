require 'app/nokia.rb'
require 'app/cat.rb'
require 'app/ground.rb'
require 'app/ground_tile.rb'


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
