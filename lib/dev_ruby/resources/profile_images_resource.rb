# frozen_string_literal: true

module DevRuby
  module Resources
    class ProfileImagesResource < BaseResource
      def find_by_username(username)
        response = get_request("profile_images/#{username}")

        if Helpers.expected_response?(response, 200)
          profile_image = DevRuby::Objects::ProfileImage.new(response.body)

          Success(profile_image)
        else
          Failure(error_parser(response))
        end
      end
    end
  end
end
