require 'app/scenes/fishing_finished_scene.rb'

class FishingScene
  attr_reader :fish_type, :frame, :fish, :bubbles, :bubbles_top, :weeds, :hook
  attr_accessor :progress

  def initialize(next_scene)
    @return_scene = next_scene
    @fish_type = rand(4)
    @start_at = Kernel.tick_count
    @frame = FishingFrame.new
    @hook = FishingHook.new(40, 0, 44)
    @fish = Fish.new(60, 5 + rand(30), fish_type)
    @bubbles = rand(10).map { random_bubble }
    @bubbles_top = rand(10).map { random_bubble }
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
    if args.inputs.keyboard.key_down.up
      hook.y += 1
    end

    if args.inputs.keyboard.key_down.down
      hook.y -= 1
    end

    if args.state.tick_count.zmod?(20)
      move_bubbles
      generate_bubble
      fish.move

      hook.y -= 1

      if (@start_at + 2.seconds).elapsed?
        decay_speed = (@start_at + 20.seconds).elapsed? ? 2 : 1
        if fish.body_rect.intersect_rect?(hook.body_rect)
          @progress += 1
        else
          @progress -= decay_speed
        end

        @progress = @progress.clamp(0, 38)
      end
    end

    render(args)
  end

  private

  def generate_bubble
    if rand > 0.8
      if rand > 0.5
        bubbles << random_bubble
      else
        bubbles_top << random_bubble
      end
    end
  end

  def render(args)
    args.nokia.sprites << bubbles
    args.nokia.sprites << hook
    args.nokia.sprites << fish
    args.nokia.sprites << bubbles_top
    args.nokia.sprites << weeds
    args.nokia.sprites << frame
    args.nokia.solids << [38, 5, 2, progress] if progress > 0
  end

  def move_bubbles
    bubbles.each { |bubble| bubble.move }
    bubbles_top.each { |bubble| bubble.move }
    bubbles.delete_if { |bubble| bubble.y > 47 }
  end

  def random_bubble
    Bubble.new(45 + rand(37), rand(30) - 6, rand > 0.5 ? :small : :big, 45, 83)
  end
end
