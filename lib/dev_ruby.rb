# frozen_string_literal: true

require 'faraday'
require_relative 'dev_ruby/version'

module DevRuby
  autoload :Client, 'dev_ruby/client'
  autoload :Error, 'dev_ruby/error'
  autoload :Collection, 'dev_ruby/collection'

  # resources
  autoload :BaseResources, 'dev_ruby/resources/base_resource'

  # objects
  autoload :BaseObject, 'dev_ruby/objects/base_object'
end
