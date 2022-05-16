# frozen_string_literal: true

require 'test_helper'

class TestHelpers < Minitest::Test
  def test_expected_response
    response = OpenStruct.new(status: 200)

    assert DevRuby::Helpers.expected_response?(response, 200)
    assert_equal false, DevRuby::Helpers.expected_response?(response, 201)
  end
end
