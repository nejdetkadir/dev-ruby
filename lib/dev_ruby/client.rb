# frozen_string_literal: true

module DevRuby
  class Client
    BASE_URL = 'https://dev.to/api'
    AUTHORIZATION_KEY = 'api-key'

    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter, stubs: nil)
      @api_key = api_key
      @adapter = adapter
      @stubs = stubs # Test stubs for requests
    end

    def articles
      DevRuby::Resources::ArticlesResource.new(self)
    end

    def comments
      DevRuby::Resources::CommentsResource.new(self)
    end

    # rubocop:disable Layout/LineLength
    def connection
      @connection ||= Faraday.new(BASE_URL) do |conn|
        conn.headers[AUTHORIZATION_KEY] = api_key
        conn.request :json
        conn.response :json, content_type: 'application/json'
        conn.response :logger, DevRuby.logger, body: true, bodies: { request: true, response: true } if DevRuby.log_api_bodies
        conn.adapter adapter, @stubs
      end
    end
    # rubocop:enable Layout/LineLength
  end
end
