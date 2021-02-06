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

    args.nokia.sprites << [@bg, @button]
  end
end
