# frozen_string_literal: true

module DevRuby
  class Helpers
    class << self
      def expected_response?(response, expected_status)
        response.status == expected_status
      end
    end
  end
end
