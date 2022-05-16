# frozen_string_literal: true

module DevRuby
  module Resources
    class TagsResource < BaseResource
      def all(**params)
        params = to_default_pagination_params(params)

        response = get_request('tags', params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Tag,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end

      def followed_tags(**params)
        params = to_default_pagination_params(params)

        response = get_request('tags', params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Tag,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end
    end
  end
end
