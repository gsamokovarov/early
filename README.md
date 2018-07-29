# Early

Early checks for environment variables availability, so you don't have to. Hook
it early in your program to require or default a variable and then work with
`ENV` like you normally would. Extremely useful for [Twelve-Factor apps][12f].

## Usage

Add this line to your application's Gemfile:

```ruby
gem 'early', require: false
```

Afterwards, make sure to call `Early` as early as possible in your application,
to check the `ENV` variables, before you use them in your configuration layer:

```ruby
require 'early'

Early do
  require :DATABASE_URL
  require :REDIS_URL

  default :PROVIDER, :generic
end
```

The configuration will require the presence of `DATABASE_URL` and `REDIS_URL`
and will raise `Early::Error` if any of them is missing. It will also set a
default value to the env `PROVIDER`.

### Rails

If you want to use early with Rails, you can store the early configuration in
`config/early.rb`:


```ruby
require 'early'

Early do
  require :ADMIN_NAME, :ADMIN_PASSWORD
  require :MEETUP_API_KEY
end
```

More importantly, require it in `config/boot.rb`, which is executed before the
`config/application.rb` and `config/initializers` files:

```ruby
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup'

require_relative 'early' # 👈
```

This will make sure, that the rules you wanted early to enforce have been
applied before any code in `config` has been run.

### Travis

If you are using Travis CI, you can auto-load the environment variables
specified in `.travis.yml` with:

```ruby
require 'early'

Early :development do
  travis
end
```

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).

[12f]: https://12factor.net
