# frozen_string_literal: true

module DevRuby
  module Resources
    class ReadinglistsResource < BaseResource
      def all(**params)
        params = to_default_pagination_params(params)

        response = get_request('readinglist', params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Article,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end
    end
  end
end
