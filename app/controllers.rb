HollabackAdmin.controllers  do
  #TODO: extract to a class
  get :index do
    @whitelisted_emails   = whitelisted_email_count,
    @unprocessed_messages = unprocessed_messages_count,
    @scheduled_messages   = scheduled_messages_count
    @message_schedule     = MessageSchedule.new(redis)
    render 'index'
  end

  get :whitelist do
    @whitelist = Whitelist.load(redis)
    render 'whitelist'
  end
end
