class ScheduledMessage
  def initialize(payload)
    @payload = payload
  end

  #TODO
  def subject
    "This is a very long test subject to an email that was never sent"
  end

  #TODO
  def deliver_on
    Time.now + (rand(96) * 60 * 60)
  end
private
  def payload
    @payload
  end
end
