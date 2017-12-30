# Early

Early checks for environment variables availability, so you don't have to. Hook
it early in your program to require or default a variable and then work with
`ENV` like you normally would. Extremely useful for [Twelve-Factor apps][12f].

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'early'
```

Afterwards make sure to call `Early` as early as possible in your application,
to check the `ENV` variables, before you use them in your configuration layer.

## Usage

```ruby
Early do
  require :REDIS_URL
  default :PROVIDER, :generic
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/gsamokovarov/early. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Early project’s codebases, issue trackers, chat
rooms and mailing lists is expected to follow the [code of
conduct](https://github.com/gsamokovarov/early/blob/master/CODE_OF_CONDUCT.md).

[12f]: https://12factor.net
