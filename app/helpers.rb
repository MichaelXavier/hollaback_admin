HollabackAdmin.helpers do
  def redis
    settings.redis
  end

  def whitelisted_email_count
    redis.scard('whitelist')
  end

  def unprocessed_messages_count
    redis.llen('messages') 
  end

  def scheduled_messages_count
    redis.zcard('schedule')
  end
end
