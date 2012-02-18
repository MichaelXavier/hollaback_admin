module HollabackInbound
  class WhitelistFilter
    def initialize(app, &blk)
      @app   = app
      @redis = blk.call
    end

    def call(env)
      params = ::Rack::Request.new(env).params
       email_permitted?(params['From']) ? @app.call(env) : unauthorized
    end
  private

    def unauthorized
      [403,
        { 'Content-Type'   => 'text/plain',
          'Content-Length' => '0' },
        []]
    end

    def redis
      @redis
    end

    def email_permitted?(from)
      ::Whitelist.includes?(redis, from)
    end
  end
end
