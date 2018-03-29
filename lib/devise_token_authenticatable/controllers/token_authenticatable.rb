require 'jwt'

module Devise
  module Controllers
    module TokenAuthenticatable
      extend ActiveSupport::Concern

      included do
        Devise.mappings.keys.each do |mapping|
          class_eval <<-METHODS, __FILE__, __LINE__ + 1
            def set_#{mapping}_access_token!
              return unless #{mapping}_signed_in?
              response.set_header("X-#{mapping.to_s.split('_').map(&:capitalize).join('-')}-Token", current_#{mapping}.access_token)
            end

            def token_authenticate_#{mapping}!(opts={})
              authenticate_#{mapping}!(opts)
              set_#{mapping}_access_token!
            end
          METHODS
        end
      end
    end
  end
end
