require 'jwt'

module Devise
  module Models
    module TokenAuthenticatable
      extend ActiveSupport::Concern

      def self.required_fields(klass)
        []
      end

      def access_token
        current_sign_in_at = respond_to?(:timedout?) && Time.now.utc

        Base64.strict_encode64(JWT.encode({ id: id, current_sign_in_at: current_sign_in_at }, Devise.secret_key, 'HS256'))
      end
    end
  end
end
