require 'active_support/core_ext/numeric/time'
require 'active_support/json'

module HollabackInbound
  module Helpers
    def simplify_payload(json)
      date = json.fetch('Headers').detect {|h| h['Name'] == 'Date'}.fetch('Value')
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
      redis.rpush('messages', simplify_payload(payload).to_json)
    end
  end
end
