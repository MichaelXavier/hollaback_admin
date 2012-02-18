module HollabackInbound
  class Helpers
    def simplify_payload(json)
      offset = calculate_offset(json['Headers']['Date'])
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
      #TODO  
    end

    def store(payload)
      redis.lpush('messages', simplify_payload(payload).to_json)
    end
  end
end
