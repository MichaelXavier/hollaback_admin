# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^hollaback_inbound/(.+)\.rb$}) { |m| "spec/hollaback_inbound/#{m[1]}_spec.rb" }
  watch(%r{^hollaback_admin/(.+)\.rb$})   { |m| "spec/hollaback_admin/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^app/(.+)\.rb$})          { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})          { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$}) { "spec" }
end

