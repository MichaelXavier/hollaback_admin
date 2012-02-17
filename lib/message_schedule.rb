class MessageSchedule
  def initialize(redis)
    @redis = redis
  end

  def empty?
    false #TODO
  end

  def soonest(count)
    [ScheduledMessage.new("TODO")] #TODO
  end

private
  def redis
    @redis
  end
end
