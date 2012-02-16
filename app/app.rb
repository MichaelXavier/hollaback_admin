class HollabackAdmin < Padrino::Application
  register SassInitializer
  register Padrino::Rendering
  register Padrino::Helpers

  configure do
    set :redis, Redis::Namespace.new(:hollaback, :redis => Redis.new)
  end
end
