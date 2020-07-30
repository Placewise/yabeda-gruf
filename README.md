# Yabeda::Gruf

Metrics for gruf.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yabeda-gruf'
```

And then execute:

    $ bundle

## Usage

Before server starts, `Yabeda.configure!` will be executed!

Add `Yabeda::Gruf::ServerInterceptor` and `Yabeda::Gruf::ServerHook` in gruf configuration.
Preferably at the beginning of interceptor chain.

```ruby
Gruf.configure do |c|
  c.interceptors.use(Yabeda::Gruf::ServerInterceptor)
  c.hooks.use(Yabeda::Gruf::ServerHook)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Boostcom/yabeda-gruf.
