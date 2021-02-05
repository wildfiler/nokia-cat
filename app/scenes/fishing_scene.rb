class FishingScene
  def initialize(next_scene)
    @return_scene = next_scene
  end

  def init(args)
    args.state.frame = FishingFrame.new
    args.state.hook = FishingHook.new(40)
    args.state.fish = Fish.new(60, 24)
    args.state.bubbles = [
    ]
    args.state.bubbles_top = [
    ]
    args.state.weeds = 5.times.map do |i|
      Weed.new(45 + i * 7, 2, rand(4))
    end
    @progress = 10
  end

  def next_scene
    if @progress >= 38
      @return_scene
    end
  end

  def tick(args)
    if args.state.tick_count.zmod?(20)
      args.state.bubbles.each do |bubble|
        bubble.y += 1 if rand > 0.1
        bubble.x += 1.rand_sign if rand > 0.7
        bubble.x = bubble.x.clamp(45, 83)
      end

      args.state.bubbles_top.each do |bubble|
        bubble.y += 1 if rand > 0.1
        bubble.x += 1.rand_sign if rand > 0.7
        bubble.x = bubble.x.clamp(45, 83)
      end

      args.state.bubbles.delete_if { |bubble| bubble.y > 47 }

      if rand > 0.8
        if rand > 0.5
          args.state.bubbles << Bubble.new(45 + rand(37), -6, rand > 0.5 ? :small : :big)
        else
          args.state.bubbles_top << Bubble.new(45 + rand(37), -6, rand > 0.5 ? :small : :big)
        end
      end

      args.state.hook.y -= 1

      if rand > 0.3
        args.state.fish.y += 1.rand_sign
        args.state.fish.x += 1.rand_sign if rand > 0.3

        args.state.fish.y = args.state.fish.y.clamp(5, 35)
        args.state.fish.x = args.state.fish.x.clamp(50, 60)
      end

      if 1.seconds.elapsed?

        if [0, args.state.fish.y, 2, 13].intersect_rect?([0, args.state.hook.y, 2, 10])
          @progress += 1
        else
          @progress -= 1
        end

        @progress = @progress.clamp(0, 38)
      end
    end

    if args.inputs.keyboard.key_down.up
      args.state.hook.y += 1
    end

    if args.inputs.keyboard.key_down.down
      args.state.hook.y -= 1
    end

    args.state.hook.y = args.state.hook.y.clamp(0, 40)

    args.nokia.sprites << args.state.bubbles
    args.nokia.sprites << args.state.hook
    args.nokia.sprites << args.state.fish
    args.nokia.sprites << args.state.bubbles_top
    args.nokia.sprites << args.state.weeds
    args.nokia.sprites << args.state.frame
    args.nokia.solids << [38, 5, 2, @progress] if @progress > 0
  end
end
