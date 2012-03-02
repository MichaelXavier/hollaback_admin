module HollabackAdmin
  class Authentication < ::Rack::Auth::Basic
    def initialize(app, username=nil, password=nil, realm = nil)
      @username = username
      @password = password
      super(app, realm)
    end

    def valid?(auth)
      username, password = auth.credentials
      username == @username && password == @password
    end
  end
end
