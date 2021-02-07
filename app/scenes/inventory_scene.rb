require 'app/inventory_info.rb'

class InventoryScene
  attr_reader :info

  def initialize(next_scene, world_clock, cat)
    @cat = cat
    @next_scene = next_scene
    @close_at = nil
    @world_clock = world_clock
    @info = InventoryInfo.new(world_clock, cat)
  end

  def next_scene
    if @close_at&.elapsed?
      @close_at = nil
      @next_scene
    end
  end

  def init(args)
    @world_clock.pause!
  end

  def tick(args)
    if args.inputs.keyboard.key_down.i
      @close_at = args.state.tick_count + 0.3.seconds

      args.audio[0] = {
        input: "sounds/blip5.wav",
        x: 0,
        y: 0,
        z: 0.0,
        gain: 1.0,
        pitch: 1.0,
        looping: false,
        paused: false
      }
    end

    if args.inputs.keyboard.key_down.down
      @info.down
    end

    if args.inputs.keyboard.key_down.up
      @info.up
    end

    if args.state.tick_count.zmod?(10)
      if args.inputs.keyboard.down
        @info.down
        @info.down
        @info.down
      end

      if args.inputs.keyboard.up
        @info.up
        @info.up
        @info.up
      end
    end

    args.nokia.sprites << [@info]
    args.nokia.sprites << [0, 0, 84, 48, "sprites/inventory-frame.png"]
  end
end
