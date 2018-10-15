require 'devise/strategies/authenticatable'
require 'jwt'

module Devise
  module Strategies
    class TokenAuthenticatable < Authenticatable
      attr_accessor :user_id, :current_sign_in_at

      def authenticate!
        env['devise.skip_trackable'] = true

        resource = user_id.present? && mapping.to.find_for_database_authentication(authentication_hash)

        fail(:timeout) if resource.respond_to?(:timedout?) && resource.timedout?(current_sign_in_at)

        if validate(resource)
          success!(resource)
        end

        fail(:timeout) unless resource
      end

      def valid?
        valid_for_http_auth?
      end

      def store?
        super && !mapping.to.skip_session_storage.include?(authentication_type)
      end

    private

      def valid_for_http_auth?
        request.authorization && with_authentication_hash(:http_auth, http_auth_hash)
      end

      def with_authentication_hash(auth_type, auth_values)
        self.authentication_hash, self.authentication_type = {}, auth_type
        self.user_id = auth_values['id']
        self.current_sign_in_at = auth_values['current_sign_in_at']

        parse_authentication_key_values(auth_values, ['id'])
      end

      def http_auth_hash
        decode_credentials
      end

      def decode_credentials
        return {} unless request.authorization && request.authorization =~ /^Bearer (.*)/mi

        payload = JWT.decode(Base64.decode64($1), Devise.secret_key, true, { algorithm: 'HS256' }).first
        payload['current_sign_in_at'] = Time.parse(payload['current_sign_in_at']) if payload['current_sign_in_at'].present?
        payload
      rescue JWT::DecodeError
        {}
      end
    end
  end
end

Warden::Strategies.add(:token_authenticatable, Devise::Strategies::TokenAuthenticatable)
