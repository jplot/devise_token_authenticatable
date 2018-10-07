# DeviseTokenable

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'devise_token_authenticatable'
```

### Controllers

Create an `users` directory in your `controllers` directory.
In this `users` directory, create a `sessions` controller.
Override the `create` action like this :

```ruby
class Users::SessionsController < Devise::SessionsController
  def create
    super do
      set_user_access_token!
    end
  end
end
```

In the same `users` directory than previous, create a `registrations` controller.
Update it like this :

```ruby
class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :set_user_access_token!, only: %i[edit update destroy]
end
```

Add this in your application controller

```ruby
class ApplicationController < ActionController::Base
  include Devise::Controllers::TokenAuthenticatable
end
```

Use "before_action :token_authenticate_user!" instead of "before_action :authenticate_user!"

### Models

In your `user` model, add the module `:token_authenticatable` next to other devise's modules
Example :

```ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable
end
```

### Configs

You can add uncomment the `timeoutable` devise module to set an expiry date to your token.
Choose token's lifetime in `devise.rb`

```ruby
config.timeout_in = 30.minutes
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
