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

  def format_datetime(datetime)
    datetime.to_formatted_s(:long_ordinal)
  end
end
