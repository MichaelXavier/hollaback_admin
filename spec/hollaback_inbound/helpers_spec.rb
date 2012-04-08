require 'hollaback_inbound/helpers'

module HollabackInbound
  describe Helpers do
    class HelpersTest; include HollabackInbound::Helpers; end

    subject { HelpersTest.new }

    describe "#calculate_offset" do
      it "returns 0 for GMT" do
        subject.calculate_offset("Fri, 17 Feb 2012 20:19:46 -0000").
          should == 0
      end

      it "returns the proper time for pacific time" do
        subject.calculate_offset("Fri, 17 Feb 2012 20:19:46 -0800").
          should == -28800
      end
    end

    describe "payload handling" do
      let(:payload) do
        {
          "Date"     => "Fri, 17 Feb 2012 20:19:46 -0800",
          "From"     => "joe@example.com",
          "To"       => "3h@hollaback.example.com",
          "Subject"  => "holla back!",
          "TextBody" => "woop woop"
        }
      end

      describe "#simplify_payload" do
        it "parses out the relevant data" do
          subject.simplify_payload(payload).should == {
            'from'           => "joe@example.com",
            'to'             => "3h@hollaback.example.com",
            'subject'        => "holla back!",
            'body'           => "woop woop",
            'offset_seconds' => -28800
          }
        end
      end

      describe "#store" do
        let(:redis) { mock("Redis", :rpush => 1) }

        before(:each) do
          subject.stub(:redis).and_return(redis)
        end

        it "pushes the simplified payload to the end of the message queue" do
          redis.should_receive(:rpush).with do |key, json|
            key == "messages" &&
            JSON.parse(json) == {
              'from'           => "joe@example.com",
              'to'             => "3h@hollaback.example.com",
              'subject'        => "holla back!",
              'body'           => "woop woop",
              'offset_seconds' => -28800
            }
          end

          subject.store(payload)
        end
      end
    end
  end
end
