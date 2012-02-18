Padrino.configure_apps do
  #TODO: make configurable
  set :redis, Redis::Namespace.new(:hollaback, :redis => Redis.new)
end

# Mounts the core application for this project
Padrino.mount("HollabackAdmin::App",
              :app_file => 'hollaback_admin/app.rb').to('/')
