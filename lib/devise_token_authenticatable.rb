require 'devise'
require 'devise_token_authenticatable/models/token_authenticatable'
require 'devise_token_authenticatable/strategies/token_authenticatable'
require 'devise_token_authenticatable/rails'

module Devise
  mattr_accessor :token_ip_verifier
  @@token_ip_verifier = false
end

Devise.add_module :token_authenticatable, controller: true, model: true, strategy: true, no_input: true
