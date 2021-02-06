require 'app/map.rb'
require 'app/camera.rb'
require 'app/cat.rb'
require 'app/scenes/inventory_scene.rb'

class MapScene
  attr_reader :map, :camera, :cat

  def initialize
    @map = Map.new
    @cat = Cat.new(3, 2, @map)
    @camera = Camera.new(10, 10)
    @inventory = InventoryScene.new(self, cat)
    @camera.map = @map
    @camera.cat = @cat
    camera.follow(cat)
    @go_fish = false
    @test_scene = false
    @show_inventory_at = nil
  end

  def init(args)

  end

  def next_scene
    if @go_fish
      @go_fish = false
      FishingScene.new(self, cat)
    elsif @show_inventory_at&.elapsed?
      @show_inventory_at = nil
      @inventory
    end
  end

  def tick(args)
    events = nil

    if args.inputs.keyboard.key_down.left
      events = cat.move(-1, 0)
    end
    if args.inputs.keyboard.key_down.right
      events = cat.move(1, 0)
    end
    if args.inputs.keyboard.key_down.up
      events = cat.move(0, 1)
    end
    if args.inputs.keyboard.key_down.down
      events = cat.move(0, -1)
    end

    if args.inputs.keyboard.key_down.i
      @show_inventory_at = args.state.tick_count + 0.3.seconds

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

    if args.inputs.keyboard.key_down.f
      @test_scene = true
    end

    if events && !events.empty?
      events.each do |event|
        case event
        when :go_fish
          @go_fish = true
        end
      end
    end

    args.nokia.sprites << @camera
  end
end
