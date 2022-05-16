# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'dev_ruby'

require 'minitest/autorun'
require 'mocha/minitest'
require 'faraday'

module Minitest
  class Test
    def stub_request(path:, method:, response:, body: {})
      Faraday::Adapter::Test::Stubs.new do |stub|
        arguments = [method, "https://dev.to/api/#{path}"]
        arguments << body.to_json if %i[post put patch].include?(method)
        stub.send(*arguments) { |_| response }
      end
    end

    def stub_response(fixture:, status:, headers: {})
      [status, headers, JSON.parse(File.read("test/fixtures/#{fixture}.json"))]
    end
  end
end
