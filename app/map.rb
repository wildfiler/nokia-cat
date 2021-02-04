require 'app/ground_tile.rb'

class Map
  attr_reader :width, :height

  def initialize
    load
  end

  def ground(x, y)
    return if x.negative? || y.negative?
    @ground.dig(y, x)
  end

  def object(x, y)
    return if x.negative? || y.negative?
    @object.dig(y, x)
  end

  def collisions(x, y)
    return true if x.negative? || y.negative? || x >= width || y >= height
    @collisions.dig(y, x)
  end

  def load
    map_csv = $gtk.read_file("maps/map_ground.csv").lines.reverse.map { |line| line.strip.split(',').map(&:to_i)}

    @ground = map_csv.map.with_index do |tiles, y|
      tiles.map.with_index do |tile_type, x|
        next if tile_type.negative?

        GroundTile.new(x * 32, y * 32, tile_type)
      end
    end

    @height = @ground.length
    @width = @ground[0].length

    map_csv = $gtk.read_file("maps/map_objects.csv").lines.reverse.map { |line| line.strip.split(',').map(&:to_i)}

    @object = map_csv.map.with_index do |tiles, y|
      tiles.map.with_index do |tile_type, x|
        next if tile_type.negative?

        GroundTile.new(x * 32, y * 32, tile_type)
      end
    end

    map_csv = $gtk.read_file("maps/map_collisions.csv").lines.reverse.map { |line| line.strip.split(',').map(&:to_i)}

    @collisions = map_csv.map.with_index do |tiles, y|
      tiles.map.with_index do |tile_type, x|
        tile_type.positive?
      end
    end
  end
end
