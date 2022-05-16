# frozen_string_literal: true

module DevRuby
  module Resources
    class UsersResource < BaseResource
      def me
        response = get_request('users/me')

        if Helpers.expected_response?(response, 200)
          user = DevRuby::Objects::User.new(response.body)

          Success(user)
        else
          Failure(error_parser(response))
        end
      end

      def find(id)
        response = get_request("users/#{id}")

        if Helpers.expected_response?(response, 200)
          user = DevRuby::Objects::User.new(response.body)

          Success(user)
        else
          Failure(error_parser(response))
        end
      end

      def invite_user(**body)
        response = post_request('admin/users', body: body)

        if Helpers.expected_response?(response, 200)
          Success(response.body)
        else
          Failure(error_parser(response))
        end
      end
    end
  end
end
