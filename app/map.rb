require 'app/tile.rb'
require 'app/bridge.rb'
require 'app/fishing_spot.rb'

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

  def passable?(x, y)
    !collisions(x, y) || [34, 35, 36, 37].include?(object(x, y)&.type)
  end

  def load
    map_csv = $gtk.read_file("maps/map_ground.csv").lines.reverse.map { |line| line.strip.split(',').map(&:to_i)}

    @ground = map_csv.map.with_index do |tiles, y|
      tiles.map.with_index do |tile_type, x|
        next if tile_type.negative?

        Tile.new(x, y, tile_type)
      end
    end

    @height = @ground.length
    @width = @ground[0].length

    map_csv = $gtk.read_file("maps/map_objects.csv").lines.reverse.map { |line| line.strip.split(',').map(&:to_i)}

    @object = map_csv.map.with_index do |tiles, y|
      tiles.map.with_index do |tile_type, x|
        next if tile_type.negative?

        case tile_type
        when 62
          FishingSpot.new(x, y, tile_type)
        when 34, 35, 36, 37
          Bridge.new(x, y, tile_type)
        else
          Tile.new(x, y, tile_type)
        end
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
