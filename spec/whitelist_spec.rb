require 'redis-namespace'
require 'lib/whitelist'

describe Whitelist do
  let(:redis) { Redis::Namespace.new("hollaback_test", :redis => Redis.new) }

  before(:each) do
    redis.del('whitelist')
    redis.sadd('whitelist', "me@example.com")
  end

  after(:each) do
    redis.del('whitelist')
  end

  subject { Whitelist.new(redis, ["you@example.com"]) }

  describe "class methods" do
    subject { Whitelist }

    describe "::load" do
      it "reloads the set from redis" do
        subject.load(redis).emails.to_a.should == ["me@example.com"]
      end

      context "the key does not exist" do
        it "returns an empty set whitelist" do
          redis.del('whitelist')
          subject.load(redis).emails.should be_empty
        end
      end
    end

    describe "::includes?" do
      context "set contains the email" do
        it "returns true" do
          subject.includes?(redis, "me@example.com").should be_true
        end
      end

      context "set does not contain the email" do
        it "returns false" do
          subject.includes?(redis, "joe@example.com").should be_false
        end
      end
    end
  end

  describe "#emails" do
    it "defaults the emails to empty" do
      Whitelist.new(redis).emails.should == Set.new
    end

    it "uses the list of emails if supplied" do
      subject.emails.to_a.should == ["you@example.com"]
    end

    it "removes duplicates from the list" do
      Whitelist.new(redis, ['you@example.com', "you@example.com"]).emails.to_a.
        should == ["you@example.com"]
    end
  end

  describe "#save" do
    it "overwrites the set" do
      subject.save
      redis.smembers("whitelist").should == ["you@example.com"]
    end

    it "overwrites with multiple emails" do
      Whitelist.new(redis, %w[a@example.com b@example.com]).save
      redis.smembers("whitelist").sort.should == %w[a@example.com b@example.com]
    end
  end

  describe "#length" do
    it "delegates to the emails set" do
      subject.length.should == 1
    end
  end

  describe "#empty?" do
    it "delegates to the emails set" do
      subject.should_not be_empty
      Whitelist.new(redis).should be_empty
    end
  end
end
