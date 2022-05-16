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
gem 'dev_ruby', github: 'nejdetkadir/dev-ruby', branch: 'main'
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

Responses are returning as objects like `DevRuby::Objects::Article` with using [dry-monads](https://github.com/dry-rb/dry-monads) gem for easly error handling. Having types like `DevRuby::Objects::Article` is handy for understanding what type of object you're working with. They're built using OpenStruct so you can easily access data in a Ruby-ish way.

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
collection = client.articles.published.value!
#=> DevRuby::Collection

collection.data
#=> [#<DevRuby::Objects::Article>, #<DevRuby::Objects::Article>]

collection.data.count
#=> 3

collection.next_page
#=> "3"

collection.prev_page
#=> "1"

# Retrieve the next page
client.articles.published(per_page: 100, page: collection.next_page)
#=> DevRuby::Collection
```

## Articles
```ruby
# This endpoint allows the client to retrieve a list of articles.
# By default it will return featured, published articles ordered by descending popularity.
collection = client.articles.published.value! # per_page is optional, defaults to 20.
#=> DevRuby::Collection

# This endpoint allows the client to create a new article.
article = client.articles.create(title: 'Hello, World!',
                                  published: true,
                                  body_markdown: 'Hello DEV, this is my first post',
                                  tags: %w[discuss help],
                                  series: 'Hello series').value!
#=> DevRuby::Objects::Article

# This endpoint allows the client to retrieve a list of articles. ordered by descending publish date.
collection = client.articles.latest_published.value!
#=> DevRuby::Collection

# This endpoint allows the client to retrieve a single published article given its id.
article = client.articles.find('123456').value!
#=> DevRuby::Objects::Article

# This endpoint allows the client to update an existing article.
article = client.articles.update(id: '123456',
                                 title: 'Hello, World!').value!
#=> DevRuby::Objects::Article

# This endpoint allows the client to retrieve a single published article given its path.
article = client.articles.find_by_path(username: 'nejdetkadir', slug: 'hello-world').value!
#=> DevRuby::Objects::Article

# This endpoint allows the client to retrieve a list of published articles on behalf of an authenticated user.
# Published articles will be in reverse chronological publication order.
collection = client.articles.me.value!
#=> DevRuby::Collection

# This endpoint allows the client to retrieve a list of published articles on behalf of an authenticated user.
# Published articles will be in reverse chronological publication order
collection = client.articles.me_published.value!
#=> DevRuby::Collection

# This endpoint allows the client to retrieve a list of unpublished articles on behalf of an authenticated user.
# Unpublished articles will be in reverse chronological creation order.
collection = client.articles.me_unpublished.value!
#=> DevRuby::Collection

# This endpoint allows the client to retrieve a list of all articles on behalf of an authenticated user.
# It will return both published and unpublished articles with pagination.
# Unpublished articles will be at the top of the list in reverse chronological creation order. Published articles will follow in reverse chronological publication order
collection = client.articles.me_all.value!
#=> DevRuby::Collection

# This endpoint allows the client to retrieve a list of articles that are uploaded with a video.
# It will only return published video articles ordered by descending popularity.
collection = client.articles.videos.value!
#=> DevRuby::Collection
```

## Comments
```ruby
# This endpoint allows the client to retrieve all comments belonging to an article or podcast episode as threaded conversations.
# It will return the all top level comments with their nested comments as threads. See the format specification for further details.
collection = client.comments.all.value!
#=> DevRuby::Collection

# This endpoint allows the client to retrieve a comment as well as his descendants comments.
# It will return the required comment (the root) with its nested descendants as a thread.
# See the format specification for further details.
comment = client.comments.find('123456').value!
#=> DevRuby::Objects::Comment
```

## Follows
```ruby
# This endpoint allows the client to retrieve a list of the tags they follow.
collection = client.follows.followed_tags.value!
#=> DevRuby::Collection
```

## Followers
```ruby
# This endpoint allows the client to retrieve a list of the followers they have.
collection = client.followers.all.value!
#=> DevRuby::Collection
```

## Listings
```ruby
# This endpoint allows the client to retrieve a list of listings.
# By default it will return published listings ordered by descending freshness.
collection = client.listings.published.value!
#=> DevRuby::Collection

# This endpoint allows the client to create a new listing.
# The user creating the listing or the organization on which behalf the user is creating for need to have enough credits for this operation to be successful. The server will prioritize the organization's credits over the user's credits.
listing = client.listings.create(title: 'ACME Conference',
                                 body_markdown: 'Awesome conference',
                                 category: 'cfp',
                                 tags: %w[events]).value!
#=> DevRuby::Objects::Listing

# This endpoint allows the client to retrieve a list of listings belonging to the specified category.
# By default it will return published listings ordered by descending freshness.
collection = client.listings.published_by_category(category: 'cfp').value!
#=> DevRuby::Collection

# This endpoint allows the client to retrieve a single listing given its id.
# An unpublished listing is only accessible if authentication is supplied and it belongs to the authenticated user.
listing = client.listings.find('123456').value!
#=> DevRuby::Objects::Listing

# This endpoint allows the client to update an existing listing.
article = client.listings.update(id: '123456', action: 'bump').value!
#=> DevRuby::Objects::Listing
```

## Organizations
```ruby
# This endpoint allows the client to retrieve a single organization by their username.
organization = client.organizations.find_by_username('nejdetkadir').value!
#=> DevRuby::Objects::Organization

# This endpoint allows the client to retrieve a list of users belonging to the organization
collection = client.organizations.all_users_by_username(username: 'nejdetkadir').value!
#=> DevRuby::Collection

# This endpoint allows the client to retrieve a list of listings belonging to the organization
collection = client.organizations.all_listings_by_username(username: 'nejdetkadir').value!
#=> DevRuby::Collection

# This endpoint allows the client to retrieve a list of Articles belonging to the organization 
collection = client.organizations.all_articles_by_username(username: 'nejdetkadir').value!
#=> DevRuby::Collection
```

## Podcast Episodes
```ruby
# This endpoint allows the client to retrieve a list of podcast episodes.
collection = client.podcast_episodes.published.value!
#=> DevRuby::Collection
```

## Readinglists
```ruby
# This endpoint allows the client to retrieve a list of readinglist reactions along with the related article for the authenticated user.
# Reading list will be in reverse chronological order base on the creation of the reaction.
collection = client.readinglists.all.value!
#=> DevRuby::Collection
```

## Tags
```ruby
# This endpoint allows the client to retrieve a list of tags that can be used to tag articles.
# It will return tags ordered by popularity.
collection = client.tags.all.value!
#=> DevRuby::Collection

# This endpoint allows the client to retrieve a list of the tags they follow.
collection = client.tags.followed_tags.value!
#=> DevRuby::Collection
```

## Users
```ruby
# This endpoint allows the client to retrieve a list of published articles on behalf of an authenticated user.
user = client.users.me.value!
#=> DevRuby::Objects::User

# This endpoint allows the client to retrieve a single user, either by id or by the user's username
user = client.users.find('123456').value!
#=> DevRuby::Objects::User

invitation = client.users.invite_user(email: 'user@example.com', name: 'string').value!
#=> true
```

## Profile Images
```ruby
profile_image = client.profile_images.find_by_username('nejdetkadir').value!
#=> DevRuby::Objects::ProfileImage
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
