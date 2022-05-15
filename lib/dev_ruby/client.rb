# frozen_string_literal: true

module DevRuby
  class Client
    BASE_URL = 'https://dev.to/api'
    API_KEY = 'api-key'

    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter, stubs: nil)
      @api_key = api_key
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    def articles
      DevRuby::Resources::ArticlesResource.new(self)
    end

    def connection
      @connection ||= Faraday.new(BASE_URL) do |conn|
        conn.headers[API_KEY] = api_key
        conn.request :json
        conn.response :json, content_type: 'application/json'
        conn.adapter adapter, @stubs
      end
    end
  end
end
