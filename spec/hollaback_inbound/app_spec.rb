require 'spec_helper'

module HollabackInbound
  describe App do
    let(:app) { Padrino.application }
    let(:redis) { Redis::Namespcae.new("hollaback_test",
                                       :redis => Redis.new) }

    before(:each) do
      redis.sadd('whitelist', "me@example.com")
    end

    after(:each) do
      redis.rem('whitelist')
    end

    context "posting JSON" do
      context "email is found" do
        it "returns a 200"
        it "stores the inbound message"
      end

      context "email is not found" do
        it "returns a 403"
      end
    end

    context "not posting JSON" do
      it "returns a 415"
    end
  end
end
