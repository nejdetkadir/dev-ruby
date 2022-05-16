[![Gem Version](https://badge.fury.io/rb/dev_ruby.svg)](https://badge.fury.io/rb/dev_ruby)
![test](https://github.com/nejdetkadir/dev-ruby/actions/workflows/test.yml/badge.svg?branch=main)
![rubocop](https://github.com/nejdetkadir/dev-ruby/actions/workflows/rubocop.yml/badge.svg?branch=main)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Ruby Version](https://img.shields.io/badge/ruby_version->=_2.6.0-blue.svg)

# DevRuby
Ruby bindings for DEV API

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'dev_ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dev_ruby

## Configuration
```ruby
DevRuby.configure do |config|
  config.logger = ::Logger.new($stdout).tap { |d| d.level = Logger::DEBUG }
  config.log_api_bodies = true
  config.per_page = 20
end
```

## Usage
To access the API, you'll need to create a DevRuby::Client and pass in your API key. You can find your API key at [https://developers.forem.com/api](https://developers.forem.com/api)

```ruby
client = DevRuby::Client.new(api_key: ENV['DEV_API_KEY'])
```
The client then gives you access to each of the resources.

## Resources
The gem maps as closely as we can to the DEV API so you can easily convert API examples to gem code.

Responses are returning as objects like DevRuby::Article with using [dry-monads](https://github.com/dry-rb/dry-monads) gem for easly error handling. Having types like DevRuby::Article is handy for understanding what type of object you're working with. They're built using OpenStruct so you can easily access data in a Ruby-ish way.

```ruby
# Sample request with dry-monads

client = DevRuby::Client.new(api_key: ENV['DEV_API_KEY'])

operation = client.articles.create(title: 'My Article',
                                   body: 'This is my article')

if operation.success?
  article = operation.success

  puts 'Article created successfully'
  puts "Article ID: #{article.id}"
end

if operation.failure?
  errors = operation.failure

  puts 'Article creation failed'
  puts "Error: #{errors}"
end

operation.value! # Returns the article if successful or return error if not successful
```

## Pagination

Some endpoints return pages of results. The result object will have a data key to access the results, as well as metadata like next_page and prev_page for retrieving the next and previous pages. You may also specify the

```ruby
results = client.articles.published.value! # per_page is optional, defaults to 20.
#=> DevRuby::Collection[#<DevRuby::Article>, #<DevRuby::Article>]

results.data
#=> [#<DevRuby::Article>, #<DevRuby::Article>]

results.data.count
#=> 3

results.next_page
#=> "3"

results.prev_page
#=> "1"

# Retrieve the next page
client.articles.published(per_page: 100, page: results.next_page)
#=> DevRuby::Collection[#<DevRuby::Article>, #<DevRuby::Article>]
```

## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/nejdetkadir/dev-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nejdetkadir/dev-ruby/blob/main/CODE_OF_CONDUCT.md).

## License
The gem is available as open source under the terms of the [MIT License](LICENSE).

## Code of Conduct
Everyone interacting in the DevRuby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nejdetkadir/dev-ruby/blob/main/CODE_OF_CONDUCT.md).
