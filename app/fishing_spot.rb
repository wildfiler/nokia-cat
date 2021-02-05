class FishingSpot < Tile
  FRAMES = [0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0]

  def passable?
    true
  end

  def events
    [:go_fish]
  end

  def tile_x
    super + FRAMES[0.frame_index(10, 20, true)] * 13
  end
end
