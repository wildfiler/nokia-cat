class SellerSprite
  attr_sprite
  attr_reader :sum, :text

  def initialize(cat, sum)
    @cat = cat
    @fish = [
      Fish.new(50, 14, 0),
      Fish.new(50, 2, 1),
      Fish.new(-3, 15, 2),
      Fish.new(-3, 2, 3),
    ]

    @sum = sum

    @text = Text.new("Total: #{@sum}$")
  end

  def draw_override(ffi_draw)
    @text.draw(ffi_draw, 3, 30)

    ffi_draw.draw_sprite_3(
      0, 0, 84, 48,
      "sprites/seller-frame.png",
      0,
      255, 255, 255, 255,
      nil, nil, nil, nil,
      false, false,
      0, 0,
      0, 0, -1, -1
    )

    @fish.each do |fish|
      fish.draw_override(ffi_draw, flip: fish.fish_type >= 2)
    end
  end
end

class SellerScene
  attr_reader :bg, :cat

  def initialize(next_scene, cat)
    @next_scene = next_scene
    @cat = cat
    @sum = cat.inventory.inject(0) do |memo, (fish_type, quantity)|
      memo += Fish::STATS[fish_type][:price] * quantity
      memo
    end
    @bg = SellerSprite.new(cat, @sum)
  end

  def init(args)
  end

  def next_scene
    if @close_at&.elapsed?
      @next_scene
    end
  end

  def tick(args)
    if args.inputs.keyboard.key_down.space
      @close_at = args.state.tick_count + 0.3.seconds

      if @sum > 0
        puts "SELL!!"
        cat.sell_inventory @sum
      end

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

    args.nokia.sprites << @bg
  end
end
