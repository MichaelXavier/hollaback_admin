require 'lib/scheduled_message'

describe ScheduledMessage do
  let(:payload) { '{"Subject":"holla back"}' }
  let(:deliver_at) { Time.now }
  let(:scheduled_message) { ScheduledMessage.new(payload, deliver_at.to_i.to_s) }

  subject { scheduled_message }

  its(:subject)    { should == 'holla back' }

  it "parses the timestamp" do
    subject.deliver_at.to_i.should == deliver_at.to_i
  end
end
