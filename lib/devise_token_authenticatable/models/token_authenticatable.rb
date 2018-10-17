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
        current_sign_in_ip = self.token_ip_verifier && remote_ip

        Base64.strict_encode64(JWT.encode({ id: id, current_sign_in_at: current_sign_in_at, current_sign_in_ip: current_sign_in_ip }, Devise.secret_key, 'HS256'))
      end

      def token_ip_verifier
        self.class.token_ip_verifier
      end

    protected

      module ClassMethods
        Devise::Models.config(self, :token_ip_verifier)
      end
    end
  end
end
