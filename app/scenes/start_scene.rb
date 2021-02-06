require 'app/button.rb'
require 'app/start_scene_background.rb'

class StartScene
  def initialize
    @bg = StartSceneBackground.new
    @button = Button.new(57, 19, 27, 13, "Start")
  end

  def init(args)
  end

  def next_scene
    if @start_at&.elapsed?
      MapScene.new
    end
  end

  def tick(args)
    if args.inputs.keyboard.key_down.space
      @button.toggle
    end

    if args.inputs.keyboard.key_up.space
      @button.toggle
      @start_at = args.state.tick_count + 0.2.seconds
    end

    args.nokia.sprites << [@bg, @button]
  end
end
