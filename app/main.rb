require 'app/nokia.rb'

require 'app/bubble.rb'
require 'app/fish.rb'
require 'app/fishing_frame.rb'
require 'app/fishing_hook.rb'
require 'app/weed.rb'
require 'app/world_clock.rb'
require 'app/scenes/fishing_scene.rb'
require 'app/scenes/fishing_finished_scene.rb'
require 'app/scenes/map_scene.rb'
require 'app/scenes/start_scene.rb'

def tick args
  if args.state.tick_count == 0
    args.state.world_clock = WorldClock.new(Time.now)
    args.state.scene = StartScene.new
    args.state.scene.init(args)
  end

  next_scene = args.state.scene.next_scene

  if next_scene
    args.state.scene = next_scene
    next_scene.init(args)
  end

  args.state.world_clock.tick(args)
  args.state.scene.tick(args)

  args.outputs.labels << { x: 8, y: 720 - 28, text: "#{$gtk.args.gtk.current_framerate.to_i}fps", r: 255 }
end

$gtk.reset


class Numeric
  def +(a)
    self + a
  end
end
