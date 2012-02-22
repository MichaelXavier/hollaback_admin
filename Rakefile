require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :development)
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = '*_spec.rb'
end

task :default => :spec

begin
  require 'hoe'
  require 'vlad'
  require 'vlad/thin'
  Vlad.load :scm => 'git'
rescue LoadError => e
  puts "Could not load vlad: #{e.message}"
end
