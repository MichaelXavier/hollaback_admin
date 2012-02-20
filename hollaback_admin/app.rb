require 'hollaback_admin/helpers'

module HollabackAdmin
  class App < ::Padrino::Application
    register SassInitializer
    register Padrino::Rendering
    register Padrino::Helpers

    helpers do
      include Helpers

      def redis
        settings.redis
      end
    end

    controllers do
      get :index do
        @whitelist        = Whitelist.load(redis)
        @message_schedule = MessageSchedule.new(redis)
        @inbound_queue    = InboundQueue.new(redis)
        render 'index'
      end

      get :whitelist do
        @whitelist = Whitelist.load(redis)
        render 'whitelist'
      end

      put :whitelist do
        Whitelist.new(redis, params.fetch('emails', [])).save
        flash[:notice] = "Whitelist updated"
        redirect back
      end
    end
  end
end
