require 'redis-namespace'
require 'lib/message_schedule'

describe MessageSchedule do
  let(:redis) do
    Redis::Namespace.new("hollaback_test", :redis => Redis.new)
  end

  let(:timestamps)       { %w[1329636687 1329636686 1329636688]}
  let(:payload)          { '{"Subject":"holla back"}'          }
  let(:message_schedule) { MessageSchedule.new(redis)          }

  subject { message_schedule }

  before(:each) do
    redis.del(*timestamps)
    timestamps.each do |ts|
      redis.zadd('schedule', ts.to_i, ts)
      redis.lpush(ts, payload)
    end
  end

  after(:each) do
    redis.del('schedule')
    redis.del(*timestamps)
  end

  its(:length) { should == 3 }

  describe "#soonest" do
    context "count of 0" do
      it "returns an empty array" do
        subject.soonest(0).should == []
      end
    end

    context "count > 0" do
      it "draws from the schedule and timestamp stores, timestamp asc order" do
        messages = subject.soonest(2)
        messages.length.should == 2
        messages[0].deliver_at.to_i.should == 1329636686
        messages[0].subject.should == "holla back"
        messages[1].deliver_at.to_i.should == 1329636687
        messages[1].subject.should == "holla back"
      end
    end
  end
end
