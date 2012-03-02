source :rubygems

# Server requirements (defaults to WEBrick)
gem 'thin'

# Project requirements
gem 'rake'
gem 'sinatra-flash', :require => 'sinatra/flash'

# Component requirements
gem 'sass'
gem 'haml'

# Padrino Stable Gem
gem 'padrino',    '0.10.5'

gem "activesupport",               "~>3.1.0", :require => false
gem "json",                        "~>1.6.5"
gem "mail",                        "~>2.3.0"
gem "rack-contrib",                "~>1.1.0", :require => false
gem "rack-content_type_validator", "~>0.2.1"
#gem "redis",                       "~>2.2.2"
# needed for variadic commands
gem "redis",                       :git => 'https://github.com/ezmobius/redis-rb.git'
gem "redis-namespace",             "~>1.1.0"
gem "sinatra-contrib",             "~>1.3.1", :require => false

group :development, :test do
  gem 'guard-rspec'
  gem 'hoe',       '~>2.12'
  gem 'vlad',      '~>2.2.4'
  gem 'vlad-git',  '~>2.2.0'
  gem 'vlad-thin', '~>1.0.0'
end

group :test do
  gem 'rspec'
  gem 'rack-test', :require => "rack/test"
end
