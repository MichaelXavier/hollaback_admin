# Mounts the core application for this project
Padrino.mount("Admin", :app_file  => 'app/hollaback_admin/app.rb',
                       :app_class => 'HollabackAdmin::App').to('/')
