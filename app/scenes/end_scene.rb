class EndScene
  attr_reader :cat

  def initialize(cat)
    @cat = cat
  end

  def next_scene
    if @return
      StartScene.new
    end
  end

  def init(args)
  end

  def tick(args)
    if args.inputs.keyboard.key_up.space
      @return = true
    end
  end
end
