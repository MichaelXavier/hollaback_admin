require 'spec_helper'

module HollabackInbound
  describe App do
    let(:app) { Padrino.application }
    let(:redis) { Redis::Namespace.new("hollaback_test",
                                       :redis => Redis.new) }
    let(:base_data) {{
      'From'     => 'me@example.com',
      'To'       => '3h@hollaback.example.com',
      'Subject'  => 'holla back',
      'TextBody' => 'woop woop',
      'Headers'  => [{
        'Name'  => 'Date',
        'Value' => "Fri, 17 Feb 2012 20:19:46 -0800"
      }]
    }}

    def post_json(path, data)
      post path, data.to_json
    end

    before(:each) do
      redis.sadd('whitelist', "me@example.com")
      redis.del('messages')
    end

    after(:each) do
      redis.del('whitelist', 'messages')
    end

    context "posting JSON" do
      before(:each) do
        header('Content-Type', 'application/json')
      end

      context "email is found" do
        it "returns a 200" do
          post_json '/inbound', base_data
          last_response.should be_ok
        end

        it "stores the inbound message" do
          post_json '/inbound', base_data
          JSON.parse(redis.lpop('messages')).should == {
            'from'           => 'me@example.com',
            'to'             => '3h@hollaback.example.com',
            'subject'        => 'holla back',
            'body'           => 'woop woop',
            'offset_seconds' => -28800
          }
        end

        it "puts the message at the end of the queue" do
          redis.lpush("messages", "old")
          post_json '/inbound', base_data
          redis.lpop("messages").should == "old"
        end
      end

      context "email is not found" do
        it "returns a 403" do
          post_json '/inbound', base_data.merge('From' => 'some1@example.com')
          last_response.status.should == 403
        end

        it "does not store the inbound message" do
          post_json '/inbound', base_data.merge('From' => 'some1@example.com')
          redis.llen('messages').should == 0
        end
      end
    end

    context "not posting JSON" do
      before(:each) do
        header('Content-Type', 'text/plain')
      end

      it "returns a 415" do
        post_json '/inbound', base_data
        last_response.status.should == 415
      end
    end
  end
end
