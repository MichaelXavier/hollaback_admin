require 'lib/message_schedule'

describe MessageSchedule do
  let(:redis) { Redis::Namespace.new("hollaback_test", :redis => Redis.new) }

  subject {MessageSchedule.new(redis) }
  describe "defaults" do
  
  end
end
