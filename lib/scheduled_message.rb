require 'active_support/json'

class ScheduledMessage
  attr_reader :subject, :deliver_at

  def initialize(payload, timestamp)
    parse_payload(payload)
    parse_timestamp(timestamp)
  end

private

  def parse_payload(payload)
    @subject = JSON.parse(payload)['Subject']
  end

  def parse_timestamp(timestamp)
    @deliver_at = Time.at(timestamp.to_i)
  end
end
