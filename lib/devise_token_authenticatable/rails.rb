require 'devise_token_authenticatable/controllers/token_authenticatable'

module DeviseTokenAuthenticatable
  class Engine < ::Rails::Engine
    ActiveSupport.on_load(:action_controller) do
      include Devise::Controllers::TokenAuthenticatable
    end
  end
end
