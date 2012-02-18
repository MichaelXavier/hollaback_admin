Padrino.configure_apps do
  #TODO: make configurable
  set :redis, Redis::Namespace.new(:hollaback, :redis => Redis.new)
end

# Mounts the core application for this project
Padrino.mount("Admin", :app_file  => 'app/hollaback_admin/app.rb',
                       :app_class => 'HollabackAdmin::App').to('/')
