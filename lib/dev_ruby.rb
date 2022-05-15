# frozen_string_literal: true

require 'faraday'
require 'awesome_print'
require_relative 'dev_ruby/version'

module DevRuby
  require_relative 'dev_ruby/helpers'
  require_relative 'dev_ruby/error'
  require_relative 'dev_ruby/client'
  require_relative 'dev_ruby/collection'

  # Resources
  require_relative 'dev_ruby/resources/base_resource'
  require_relative 'dev_ruby/resources/articles_resource'

  # Objects
  require_relative 'dev_ruby/objects/base_object'
  require_relative 'dev_ruby/objects/article'
end
