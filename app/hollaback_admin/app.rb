module HollabackAdmin
  class App < ::Padrino::Application
    register SassInitializer
    register Padrino::Rendering
    register Padrino::Helpers

    helpers do
      def redis
        settings.redis
      end

      def whitelisted_email_count
        redis.scard('whitelist')
      end

      def unprocessed_messages_count
        redis.llen('messages') 
      end

      def scheduled_messages_count
        redis.zcard('schedule')
      end

      def format_datetime(datetime)
        datetime.to_formatted_s(:long_ordinal)
      end
    end

    controllers do
      get :index do
        @whitelisted_emails   = whitelisted_email_count,
        @unprocessed_messages = unprocessed_messages_count,
        @scheduled_messages   = scheduled_messages_count
        @message_schedule     = MessageSchedule.new(redis)
        render 'index'
      end

      get :whitelist do
        @whitelist = Whitelist.load(redis)
        render 'whitelist'
      end
    end
  end
end
