module HollabackAdmin
  class Authentication < ::Rack::Auth::Basic
    def call(env)
      if @app.settings.password_protected?
        super(env)
      else
        @app.call(env)
      end
    end

    def valid?(auth)
      username, password = auth.credentials
      username == @app.settings.username && password == @app.settings.password
    end
  end
end
