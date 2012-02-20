module HollabackAdmin
  module Helpers
    def email_field_tag(name, options)
      text_field_tag(name, options.merge(:type => 'email'))
    end
  end
end
