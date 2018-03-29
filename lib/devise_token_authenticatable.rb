require 'devise_token_authenticatable/controllers/token_authenticatable'
require 'devise_token_authenticatable/models/token_authenticatable'
require 'devise_token_authenticatable/strategies/token_authenticatable'

Devise.add_module :token_authenticatable, controller: true, model: true, strategy: true, no_input: true
