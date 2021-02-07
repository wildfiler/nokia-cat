class FishMarketEntry < Tile
  def passable?
    true
  end

  def events
    [:go_market]
  end
end
