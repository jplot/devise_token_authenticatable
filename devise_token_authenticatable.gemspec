lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise_token_authenticatable/version'

Gem::Specification.new do |spec|
  spec.name          = 'devise_token_authenticatable'
  spec.version       = DeviseTokenAuthenticatable::VERSION
  spec.authors       = ['Jonathan PHILIPPE']
  spec.email         = ['pretrine@gmail.com']

  spec.summary       = %q{Token module for Devise}
  spec.description   = %q{This gem is a token module for Devise. It generates a new token at each request.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency('devise', '~> 4.4', '>= 4.4.3')
  spec.add_dependency('jwt', '~> 2.1')
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
end
