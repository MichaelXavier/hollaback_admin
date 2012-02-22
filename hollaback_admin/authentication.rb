module HollabackAdmin
  class Authentication < ::Rack::Auth::Basic
    def initialize(app, protect, username=nil, password=nil, realm = nil)
      @password_protected = protect
      @username           = username
      @password           = password
      super(app, realm)
    end

    def call(env)
      if @password_protected
        super(env)
      else
        @app.call(env)
      end
    end

    def valid?(auth)
      username, password = auth.credentials
      username == @username && password == @password
    end
  end
end
