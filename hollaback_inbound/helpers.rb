require 'active_support/core_ext/numeric/time'
require 'active_support/json'
require 'lib/inbound_queue'

module HollabackInbound
  module Helpers
    def simplify_payload(json)
      date = json.fetch('Date')
      offset = calculate_offset(date)
      {
        'from'           => json["From"],
        'to'             => json["To"],
        'subject'        => json["Subject"],
        'body'           => json["TextBody"],
        'offset_seconds' => offset
      } 
    end

    # Calculate offset in seconds from full date string
    # e.g.: Fri, 17 Feb 2012 20:19:46 -0800
    def calculate_offset(date_str)
      hours, mins, secs = DateTime.parse(date_str).strftime("%::z").split(':')
      hours.to_i.hours + mins.to_i.minutes + secs.to_i
    end

    def store(payload)
      InboundQueue.new(redis).push(simplify_payload(payload).to_json)
    end
  end
end
