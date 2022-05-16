# frozen_string_literal: true

module DevRuby
  module Resources
    class CommentsResource < BaseResource
      def all(**params)
        params = to_default_pagination_params(params)

        response = get_request('comments', params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Comment,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end

      def find(id)
        response = get_request("comments/#{id}")

        if Helpers.expected_response?(response, 200)
          comment = DevRuby::Objects::Comment.new(response.body)

          Success(comment)
        else
          Failure(error_parser(response))
        end
      end
    end
  end
end
