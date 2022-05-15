# frozen_string_literal: true

require 'test_helper'

class TestDevRuby < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DevRuby::VERSION
  end
end
