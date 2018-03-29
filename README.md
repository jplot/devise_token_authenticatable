# DeviseTokenable

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'devise_token_authenticatable'
```

install it yourself as:

Customize Devise::SessionsController. You need to create and return token in #create

```ruby
class Users::SessionsController < Devise::SessionsController
  def create
    super do
      set_user_access_token!
    end
  end
end
```

Customize Devise::RegistrationsController. add this code

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

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
