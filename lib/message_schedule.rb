require 'lib/scheduled_message'

class MessageSchedule
  def initialize(redis)
    @redis = redis
  end

  def soonest(count)
    take_messages(timestamps(count), count)
  end

  def length
    redis.zcard('schedule')
  end

  def empty?
    length == 0
  end

private

  def take_messages(tstamps, count)
    return [] if count == 0
    tstamps   = tstamps.to_a
    remaining = count
    messages = []

    while remaining > 0 && ts = tstamps.shift
      payloads_for_ts = redis.lrange(ts, 0, remaining - 1)
      messages += payloads_for_ts.map {|pl| ScheduledMessage.new(pl, ts)}
      remaining -= payloads_for_ts.length
    end

    messages
  end

  def timestamps(count)
    return [] if count == 0
    redis.zrange("schedule", 0, count - 1).to_set
  end

  def parse_timestamp(str)
    Time.at(str.to_i)
  end

  def redis
    @redis
  end
end
