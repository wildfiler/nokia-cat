class WorldClock
  attr_reader :seconds_count

  HOUR_PER_DAY = 30
  SECONDS_PER_HOUR = 3

  def initialize(time)
    @seconds_count = 0
    @last_tick_at = time.to_i

    pause!
  end

  def tick(args)
    return if pause?

    current_second = Time.now.to_i
    @seconds_count += current_second - @last_tick_at
    @last_tick_at = current_second
  end

  def jump
    @seconds_count += 30
  end

  def reset!
    @seconds_count = 0
    @last_tick_at = Time.now.to_i

    pause!
  end

  def day
    (seconds_count / (SECONDS_PER_HOUR * HOUR_PER_DAY)).to_i + 1
  end

  def hour
    (seconds_count / SECONDS_PER_HOUR).to_i % HOUR_PER_DAY
  end

  def pause!
    @pause = true
  end

  def unpause!
    return unless pause?

    @pause = false
    @last_tick_at = Time.now.to_i
  end

  def pause?
    @pause
  end
end
