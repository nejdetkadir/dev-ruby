# frozen_string_literal: true

require 'test_helper'

class TestClient < Minitest::Test
  def test_api_key
    client = DevRuby::Client.new api_key: 'test'
    assert_equal 'test', client.api_key
  end

  def test_adapter
    client = DevRuby::Client.new api_key: 'test', adapter: Faraday.default_adapter
    assert_equal Faraday.default_adapter, client.adapter
  end

  def test_api_key_required
    assert_raises(ArgumentError) { DevRuby::Client.new }
  end
end
