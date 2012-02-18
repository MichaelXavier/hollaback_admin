class Whitelist
  KEY = 'whitelist'

  attr_reader :emails

  def self.load(redis)
    new(redis).tap(&:load)
  end

  def self.includes?(redis, email)
    redis.sismember("whitelist", email)
  end

  def initialize(redis, emails = [])
    @redis  = redis
    @emails = emails
  end

  def load
    @emails = redis.smembers(KEY)
  end

  def save
    redis.del(KEY)
    redis.sadd(KEY, @emails)
  end

  def length
    @emails.length
  end

  def empty?
    @emails.empty?
  end

private
  def redis
    @redis
  end
end
