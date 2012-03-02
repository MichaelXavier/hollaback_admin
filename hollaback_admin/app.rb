require 'sinatra/config_file'
require 'hollaback_admin/helpers'
require 'hollaback_admin/authentication'

module HollabackAdmin
  class App < ::Padrino::Application
    register ::Sinatra::ConfigFile

    config_file '../config/admin_settings.yml'

    register ::SassInitializer
    register ::Padrino::Rendering
    register ::Padrino::Helpers


    if settings.password_protected
      use(Authentication, settings.username,
                          settings.password,
                          'Hollaback Admin')
    end

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
