require 'app/map.rb'
require 'app/camera.rb'
require 'app/cat.rb'
require 'app/sun.rb'
require 'app/world_shadow.rb'
require 'app/scenes/inventory_scene.rb'
require 'app/scenes/seller_scene.rb'
require 'app/scenes/end_scene.rb'

class MapScene
  attr_reader :map, :camera, :cat, :world_clock

  def initialize(world_clock)
    @world_clock = world_clock
    @map = Map.new
    @cat = Cat.new(3, 2, @map)
    @sun = Sun.new(world_clock)
    @shadow = WorldShadow.new(world_clock, map, cat)
    @camera = Camera.new(10, 10)
    @camera.map = @map
    @camera.cat = @cat
    camera.follow(cat)
    @go_fish = false
    @test_scene = false
    @show_inventory_at = nil
  end

  def init(args)
    world_clock.unpause!
  end

  def next_scene
    case
    when @end_game
      world_clock.pause!
      EndScene.new(cat)
    when @go_fish
      @go_fish = false
      FishingScene.new(self, cat)
    when @go_market
      @go_market = false
      SellerScene.new(self, cat)
    when @show_inventory_at&.elapsed?
      @show_inventory_at = nil
      InventoryScene.new(self, world_clock, cat)
    when @test_scene
      @test_scene = false
      nil
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
      world_clock.jump
    end

    if events && !events.empty?
      events.each do |event|
        case event
        when :go_fish
          @go_fish = true
        when :go_market
          @go_market = true
        end
      end
    end

    if world_clock.day > 5
      @end_game = true
    end

    args.nokia.sprites << [@camera, @shadow, @sun]
  end
end
