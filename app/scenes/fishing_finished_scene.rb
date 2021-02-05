require 'app/fishing_finished_sprite.rb'

class FishingFinishedScene
  def initialize(next_scene, type, fish_type)
    @return_scene = next_scene
    @background = FinishedFishingSprite.new(type, fish_type)
  end

  def init(args)
    @start_at = args.state.tick_count
  end

  def next_scene
    if @return
      @return_scene
    end
  end

  def tick(args)
    if args.inputs.keyboard.key_down.space || (@start_at + 10.seconds).elapsed?
      @return = true
    end

    args.nokia.sprites << @background
  end
end
