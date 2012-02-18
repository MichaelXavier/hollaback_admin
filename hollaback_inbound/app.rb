module HollabackInbound
  class App < ::Padrino::Applicaiton
    helpers do
      include Helpers
    end

    post '/' do
      store(JSON.parse(request.body))
      200
    end
  end
end
