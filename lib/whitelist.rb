require 'active_support/core_ext/module/delegation'

class Whitelist
  KEY = 'whitelist'

  attr_reader :emails
  delegate :empty?, :length, :to => :emails

  def self.load(redis)
    new(redis).tap(&:reload!)
  end

  def self.includes?(redis, email)
    redis.sismember("whitelist", email)
  end

  def initialize(redis, emails = Set.new)
    @redis  = redis
    @emails = emails.to_set
  end

  def reload!
    @emails = redis.smembers(KEY).to_set
  end

  def save
    redis.del(KEY)
    @emails.each {|email| redis.sadd(KEY, email)}
  end

private

  def redis
    @redis
  end
end
