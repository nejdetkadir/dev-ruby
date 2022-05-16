# frozen_string_literal: true

module DevRuby
  module Resources
    class ListingsResource < BaseResource
      def published(**params)
        params = to_default_pagination_params(params)

        response = get_request('listings', params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Listing,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end

      def create(**body)
        response = post_request('listings', body: { listing: body })

        if Helpers.expected_response?(response, 201)
          listing = DevRuby::Objects::Listing.new(response.body)

          Success(listing)
        else
          Failure(error_parser(response))
        end
      end

      def published_by_category(category:, **params)
        params = to_default_pagination_params(params)

        response = get_request("listings/category/#{category}", params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Listing,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end

      def find(id)
        response = get_request("listings/#{id}")

        if Helpers.expected_response?(response, 200)
          listing = DevRuby::Objects::Listing.new(response.body)

          Success(listing)
        else
          Failure(error_parser(response))
        end
      end

      def update(id:, **body)
        response = put_request("listings/#{id}", body: { listing: body })

        if Helpers.expected_response?(response, 200)
          listing = DevRuby::Objects::Listing.new(response.body)

          Success(listing)
        else
          Failure(error_parser(response))
        end
      end
    end
  end
end
