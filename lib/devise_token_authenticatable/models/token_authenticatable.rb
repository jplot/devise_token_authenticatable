require 'jwt'

module Devise
  module Models
    module TokenAuthenticatable
      extend ActiveSupport::Concern

      def self.required_fields(klass)
        []
      end

      def access_token(remote_ip = nil)
        current_sign_in_at = self.respond_to?(:timedout?) && Time.now.utc
        current_sign_in_ip = self.respond_to?(:current_sign_in_ip) && remote_ip

        Base64.strict_encode64(JWT.encode({ id: id, current_sign_in_at: current_sign_in_at, current_sign_in_ip: current_sign_in_ip }, Devise.secret_key, 'HS256'))
      end
    end
  end
end
