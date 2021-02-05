require 'app/map.rb'
require 'app/camera.rb'
require 'app/cat.rb'

class MapScene
  attr_reader :map, :camera, :cat

  def initialize
    @map = Map.new
    @cat = Cat.new(3, 2, @map)
    @camera = Camera.new(10, 10)
    @camera.map = @map
    @camera.cat = @cat
    camera.follow(cat)
    @go_fish = false
    @test_scene = false
  end

  def init(args)

  end

  def next_scene
    if @go_fish
      @go_fish = false
      FishingScene.new(self)
    elsif @test_scene
      @test_scene = false
      FishingFinishedScene.new(self, :success, rand(4))
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
