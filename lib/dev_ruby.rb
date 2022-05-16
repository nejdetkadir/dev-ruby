# frozen_string_literal: true

require 'faraday'
require 'dry-configurable'
require 'awesome_print'
require_relative 'dev_ruby/version'

module DevRuby
  extend Dry::Configurable

  setting :logger, default: ::Logger.new($stdout), reader: true
  setting :log_api_bodies, default: false, reader: true
  setting :per_page, default: 20, reader: true

  require_relative 'dev_ruby/helpers'
  require_relative 'dev_ruby/error'
  require_relative 'dev_ruby/client'
  require_relative 'dev_ruby/collection'
  require_relative 'dev_ruby/resources/base_resource'
  require_relative 'dev_ruby/resources/articles_resource'
  require_relative 'dev_ruby/resources/comments_resource'
  require_relative 'dev_ruby/resources/follows_resource'
  require_relative 'dev_ruby/resources/followers_resource'
  require_relative 'dev_ruby/resources/listings_resource'
  require_relative 'dev_ruby/resources/organizations_resource'
  require_relative 'dev_ruby/objects/base_object'
  require_relative 'dev_ruby/objects/article'
  require_relative 'dev_ruby/objects/video_article'
  require_relative 'dev_ruby/objects/comment'
  require_relative 'dev_ruby/objects/error'
  require_relative 'dev_ruby/objects/tag'
  require_relative 'dev_ruby/objects/follower'
  require_relative 'dev_ruby/objects/listing'
  require_relative 'dev_ruby/objects/organization'
  require_relative 'dev_ruby/objects/user'
end
