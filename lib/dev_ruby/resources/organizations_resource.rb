# frozen_string_literal: true

module DevRuby
  module Resources
    class OrganizationsResource < BaseResource
      def find_by_username(username)
        response = get_request("organizations/#{username}")

        if Helpers.expected_response?(response, 200)
          organization = DevRuby::Objects::Organization.new(response.body)

          Success(organization)
        else
          Failure(error_parser(response))
        end
      end

      def all_users_by_username(username:, **params)
        params = to_default_pagination_params(params)

        response = get_request("organizations/#{username}/users", params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::User,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end

      def all_listings_by_username(username:, **params)
        params = to_default_pagination_params(params)

        response = get_request("organizations/#{username}/listings", params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Listing,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end

      def all_articles_by_username(username:, **params)
        params = to_default_pagination_params(params)

        response = get_request("organizations/#{username}/articles", params: params)

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
