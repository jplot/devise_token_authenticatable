# DeviseTokenable

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'devise_token_authenticatable'
```

### Controllers

For the controllers only, we provide the generator to install the gem.
/!\ Warning, it will override `controllers/users/sessions_controller.rb` and `controllers/users/registrations_controller.rb` if they exist. /!\

```ruby
rails g devise_token_authenticatable:initializer
```

If you don't want to use the generator, you can install the gem manually (see below).

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
