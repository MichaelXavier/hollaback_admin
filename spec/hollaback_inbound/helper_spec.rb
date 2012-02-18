require 'hollaback_inbound/helpers'

module HollabackInbound
  describe Helpers do
    class HelpersTest; include Helpers; end

    subject { HelpersTest.new }

    describe "#calculate_offset" do
      it "returns 0 for GMT" do
        subject.calculate_offset("Fri, 17 Feb 2012 20:19:46 -0800").should == 0
      end
    end
  end
end
