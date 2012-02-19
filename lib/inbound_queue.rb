class InboundQueue
  def initialize(redis)
    @redis = redis
  end

  def length
    redis.llen('messages')
  end

  def push(msg)
    redis.rpush('messages', msg)
  end

  def <<(msg)
    push(msg)
    self
  end

private
  def redis
    @redis
  end
end
