require 'rack/contrib/post_body_content_type_parser'
require 'hollaback_inbound/helpers'
require 'hollaback_inbound/whitelist_filter'

module HollabackInbound
  class App < ::Padrino::Application
    use ::Rack::ContentTypeValidator, [:post], '/', {:mime_type => 'application/json'}
    use ::Rack::PostBodyContentTypeParser
    use WhitelistFilter do
      redis
    end

    helpers do
      include Helpers

      def redis
        settings.redis
      end
    end

    post :index do
      store(params)
      200
    end
  end
end
