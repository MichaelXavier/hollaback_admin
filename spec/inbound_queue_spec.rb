require 'redis-namespace'
require 'lib/inbound_queue'

describe InboundQueue do
  let(:redis) do
    Redis::Namespace.new("hollaback_test", :redis => Redis.new)
  end
  let(:inbound_queue) { InboundQueue.new(redis) }

  subject { inbound_queue }

  before(:each) do
    redis.del('messages')
  end

  after(:each) do
    redis.del('messages')
  end


  describe "#length" do
    context "queue is empty" do
      its(:length) { should == 0 }
    end
    
    context "queue is not empty" do
      before(:each) do
        redis.lpush('messages', 'one')
        redis.lpush('messages', 'two')
      end

      its(:length) { should == 2 }
    end
  end

  describe "#push" do
    it "pushes to the message to the messages queue" do
      subject.push('message1')
      redis.lpop('messages').should == 'message1'
    end

    it "pushes to the right side of the queue" do
      subject.push('message1')
      subject.push('message2')
      redis.lpop('messages').should == 'message1'
    end
  end

  describe "#<<" do
    it "pushes the message to the messages queue" do
      subject << 'message1'
      redis.lpop('messages').should == 'message1'
    end

    it "is chainable and pushes to the right side of the queue" do
      subject << 'message1' << 'message2'
      redis.lpop('messages').should == 'message1'
      redis.lpop('messages').should == 'message2'
    end
  end
end
