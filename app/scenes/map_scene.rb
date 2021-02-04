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
  end

  def init(args)

  end

  def tick(args)
    if args.inputs.keyboard.key_down.left
      cat.move(-1, 0)
    end
    if args.inputs.keyboard.key_down.right
      cat.move(1, 0)
    end
    if args.inputs.keyboard.key_down.up
      cat.move(0, 1)
    end
    if args.inputs.keyboard.key_down.down
      cat.move(0, -1)
    end

    args.nokia.sprites << @camera
  end
end
