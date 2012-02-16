HollabackAdmin.controllers  do
  #TODO: extract to a class
  get :index do
    render 'index', :locals => {
      :whitelisted_emails   => whitelisted_email_count,
      :unprocessed_messages => unprocessed_messages_count,
      :scheduled_messages   => scheduled_messages_count
    }
  end

  get :whitelist do
    render 'whitelist', :locals => {:whitelist => Whitelist.load(redis)}
  end
end
