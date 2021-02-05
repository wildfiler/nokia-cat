require 'app/scenes/fishing_finished_scene.rb'

class FishingScene
  attr_reader :fish_type, :frame, :fish, :bubbles, :bubbles_top, :weeds, :hook
  attr_accessor :progress

  def initialize(next_scene)
    @return_scene = next_scene
    @fish_type = rand(4)
    @start_at = Kernel.tick_count
    @frame = FishingFrame.new
    @hook = FishingHook.new(40)
    @fish = Fish.new(60, 5 + rand(30), fish_type)
    @bubbles = []
    @bubbles_top = []
    @weeds = 5.times.map do |i|
      Weed.new(45 + i * 7, 2, rand(4))
    end
    @progress = 10
  end

  def init(args)
  end

  def next_scene
    if progress >= 38
      FishingFinishedScene.new(@return_scene, :success, fish_type)
    elsif progress <= 0
      FishingFinishedScene.new(@return_scene, :fail, fish_type)
    end
  end

  def tick(args)
    if args.state.tick_count.zmod?(20)
      bubbles.each do |bubble|
        bubble.y += 1 if rand > 0.1
        bubble.x += 1.rand_sign if rand > 0.7
        bubble.x = bubble.x.clamp(45, 83)
      end

      bubbles_top.each do |bubble|
        bubble.y += 1 if rand > 0.1
        bubble.x += 1.rand_sign if rand > 0.7
        bubble.x = bubble.x.clamp(45, 83)
      end

      bubbles.delete_if { |bubble| bubble.y > 47 }

      if rand > 0.8
        if rand > 0.5
          bubbles << Bubble.new(45 + rand(37), -6, rand > 0.5 ? :small : :big)
        else
          bubbles_top << Bubble.new(45 + rand(37), -6, rand > 0.5 ? :small : :big)
        end
      end

      hook.y -= 1

      if rand > 0.3
        fish.y += 1.rand_sign
        fish.x += 1.rand_sign if rand > 0.3

        fish.y = fish.y.clamp(5, 35)
        fish.x = fish.x.clamp(50, 60)
      end

      if (@start_at + 2.seconds).elapsed?
        if [0, fish.y, 2, 13].intersect_rect?([0, hook.y, 2, 10])
          @progress += 1
        else
          @progress -= 1
        end

        @progress = @progress.clamp(0, 38)
      end
    end

    if args.inputs.keyboard.key_down.up
      hook.y += 1
    end

    if args.inputs.keyboard.key_down.down
      hook.y -= 1
    end

    hook.y = hook.y.clamp(0, 40)

    args.nokia.sprites << bubbles
    args.nokia.sprites << hook
    args.nokia.sprites << fish
    args.nokia.sprites << bubbles_top
    args.nokia.sprites << weeds
    args.nokia.sprites << frame
    args.nokia.solids << [38, 5, 2, @progress] if @progress > 0
  end
end
