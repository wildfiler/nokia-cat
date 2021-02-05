class Tile
  attr_reader :x, :y, :type
  def initialize(x, y, type)
    @x = x
    @y = y
    @type = type
  end

  def tile_x
    @tile_x ||= type % 10 * 13
  end

  def tile_y
    @tile_y ||= (type / 10).to_i * 13
  end

  def passable?
    true
  end

  def events; end
end
