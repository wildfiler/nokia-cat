class Text
  WIDTH_RULES = {
    [37] => 2,
    [31, 35, 45, 64, 65] => 3,
    [8, 19, 34, 43, 47, 53, 84, 85] => 4,
    [12, 22, 38, 48] => 6,
    (0..25).to_a => 5,
    (26..51).to_a => 5,
    (52..61).to_a => 5
  }

  def initialize(text, align: :left)
    @text = text
    @align = align
    @widths = Hash.new do |hash, new_index|
      hash[new_index] = WIDTH_RULES.detect do |keys, _|
        keys.include? new_index
      end&.last || 6
    end
  end

  def x_offsets
    @x_offsets ||= @text.chars.map do |char|
      char_num = char.ord

      index = case char_num
      when 65..90
        char_num - 65
      when 97..122
        char_num - 71
      when 58 then 65
      when 59 then 64
      when 47 then 84
      when 48..57
        char_num + 4
      else
        164
      end

      [index, width(index)]
    end
  end

  def text_width
    @text_width ||= x_offsets.map(&:last).inject(:+)
  end

  def width(index)
    @widths[index]
  end

  def draw(ffi_draw, x, y)
    current_x = if @align == :right
      x - text_width
    else
      x
    end

    x_offsets.each do |(x_offset, width)|
      ffi_draw.draw_sprite_3(
        current_x, y, 7, 11,
        "fonts/Efforts_Pro_dark @somepx.png",
        0,
        255, 255, 255, 255,
        x_offset * 7, 0, 7, 11,
        false, false,
        0, 0,
        0, 0, -1, -1,
      )

      current_x += width
    end
  end

  def to_s
    "#<Text \"#{@text}\">"
  end
end
