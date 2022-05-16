# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
module DevRuby
  module Resources
    class ArticlesResource < BaseResource
      def published(**params)
        params = to_default_pagination_params(params)

        response = get_request('articles', params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Article,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end

      def create(**body)
        response = post_request('articles', body: { article: body })

        if Helpers.expected_response?(response, 201)
          article = DevRuby::Objects::Article.new(response.body)

          Success(article)
        else
          Failure(error_parser(response))
        end
      end

      def latest_published(**params)
        params = to_default_pagination_params(params)

        response = get_request('articles/latest', params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Article,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end

      def find(id)
        response = get_request("articles/#{id}")

        if Helpers.expected_response?(response, 200)
          article = DevRuby::Objects::Article.new(response.body)

          Success(article)
        else
          Failure(error_parser(response))
        end
      end

      def update(id, **body)
        response = put_request("articles/#{id}", body: { article: body })

        if Helpers.expected_response?(response, 200)
          article = DevRuby::Objects::Article.new(response.body)

          Success(article)
        else
          Failure(error_parser(response))
        end
      end

      def find_by_path(username:, slug:)
        response = get_request("articles/#{username}/#{slug}")

        if Helpers.expected_response?(response, 200)
          article = DevRuby::Objects::Article.new(response.body)

          Success(article)
        else
          Failure(error_parser(response))
        end
      end

      def me(**params)
        params = to_default_pagination_params(params)

        response = get_request('articles/me')

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Article,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end

      def me_published(**params)
        params = to_default_pagination_params(params)

        response = get_request('articles/me/published', params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Article,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end

      def me_unpublished(**params)
        params = to_default_pagination_params(params)

        response = get_request('articles/me/unpublished', params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Article,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end

      def me_all(**params)
        params = to_default_pagination_params(params)

        response = get_request('articles/me/all', params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::Article,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end

      def videos(**params)
        params = to_default_pagination_params(params)

        response = get_request('videos', params: params)

        if Helpers.expected_response?(response, 200)
          collection = Collection.from_response(response: response,
                                                type: DevRuby::Objects::VideoArticle,
                                                params: params)

          Success(collection)
        else
          Failure(error_parser(response))
        end
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength
