class InventoryInfo
  attr_sprite
  attr_reader :day_text, :gold_text, :cat, :offset

  def initialize(cat)
    @cat = cat
    @day_text = Text.new("Day:")
    @gold_text = Text.new("Gold:")
    @offset = 0
  end

  def inventory
    cat.inventory
  end

  def up
    self.offset -= 1
  end

  def down
    self.offset += 1
  end

  def offset=(new_offset)
    max = ((@total_height || 0) - 41).greater(0)
    @offset = new_offset.clamp(0, max)
  end

  def draw_override(ffi_draw)
    @day_text.draw(ffi_draw, 4, 37)
    @gold_text.draw(ffi_draw, 4, 19)
    Text.new("1/5", align: :right).draw(ffi_draw, 29, 29)
    Text.new(cat.gold.to_s, align: :right).draw(ffi_draw, 29, 11)

    y = 45 + @offset
    w = 44
    left = 32
    right = left + w

    total_height = 0

    inventory.each do |(fish_type, quantity)|
      next if quantity.zero?

      fish = Fish.new(0, 0, fish_type)
      h = fish.height + 3
      total_height += h + 2

      top = y
      bottom = top - h
      ffi_draw.draw_line(left + 1, top, right - 1, top, 67, 82, 61, 255)
      ffi_draw.draw_line(left + 1, bottom, right - 1, bottom, 67, 82, 61, 255)
      ffi_draw.draw_line(left, bottom + 1, left, top - 1, 67, 82, 61, 255)
      ffi_draw.draw_line(right, bottom + 1, right, top - 1, 67, 82, 61, 255)

      fish_w = fish.width
      fish.draw_override(ffi_draw, origin_x: right - fish_w, origin_y: bottom, static: false)

      Text.new(quantity.to_s, align: :right).draw(ffi_draw, 44, bottom + (h / 2).to_i - 5)
      y -= h + 2
    end

    @total_height = total_height

    offset = @offset

    bar_offset = (42 * offset/total_height.greater(42)).to_i
    bar_height = (42 * 42/(total_height.greater(42))).to_i

    ffi_draw.draw_line(80, 46 - bar_offset - bar_height, 80, 45 - bar_offset, 67, 82, 61, 255)
  end
end
