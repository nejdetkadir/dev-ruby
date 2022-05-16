# frozen_string_literal: true

require 'dry/monads'

module DevRuby
  module Resources
    class BaseResource
      include Dry::Monads[:result]

      attr_reader :client

      def initialize(client)
        @client = client
      end

      private

      def get_request(url, params: {}, headers: {})
        client.connection.get(url, params, headers)
      end

      def post_request(url, body:, headers: {})
        client.connection.post(url, body, headers)
      end

      def patch_request(url, body:, headers: {})
        client.connection.patch(url, body, headers)
      end

      def put_request(url, body:, headers: {})
        client.connection.put(url, body, headers)
      end

      def delete_request(url, params: {}, headers: {})
        client.connection.delete(url, params, headers)
      end

      def error_parser(response)
        OpenStruct.new(status: response.status, body: response.body)
      end

      def to_default_pagination_params(params)
        params[:page] ||= 1
        params[:per_page] ||= DevRuby.per_page
        params
      end
    end
  end
end
