PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
$:.unshift(File.dirname(File.join(__FILE__, '..')))

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
