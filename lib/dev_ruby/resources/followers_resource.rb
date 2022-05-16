# frozen_string_literal: true

module DevRuby
  module Resources
    class FollowersResource < BaseResource
      def all(**params)
        params = to_default_pagination_params(params)

        response = get_request('followers/users')

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Follower,
                                                params: params)
          Success(collection)
        else
          Failure(error_parser(response))
        end
      end
    end
  end
end
