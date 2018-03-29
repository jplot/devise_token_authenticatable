require 'jwt'

module Devise
  module Models
    module TokenAuthenticatable
      extend ActiveSupport::Concern

      def self.required_fields(klass)
        []
      end

      def access_token
        Base64.strict_encode64(JWT.encode({ id: id, last_request_at: respond_to?(:timedout?) && Time.now.utc }, Devise.secret_key, 'HS256'))
      end
    end
  end
end
