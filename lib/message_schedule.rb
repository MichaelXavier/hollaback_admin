class MessageSchedule
  def initialize(redis)
    @redis = redis
  end

  def empty?
    false #TODO
  end

  def soonest(count)
    take_messages(timestamps(count), count)
  end

private

  def take_messages(tstamps, count)
    remaining = count
    [].tap do |messages|
      while ts = tstamps.shift && remaining > 0
        payloads_for_ts = redis.lrange(ts, 0, remaining)
        messages += payloads_for_ts.map {|pl| ScheduledMessage.new(pl, ts)}
        remaining -= payloads_for_ts.length
      end
    end
  end

  def timestamps(count)
    redis.zrange("schedule", 0, count).to_set
  end

  def parse_timestamp(str)
    Time.at(str.to_i)
  end

  def redis
    @redis
  end
end
