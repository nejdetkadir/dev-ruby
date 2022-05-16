# frozen_string_literal: true

require 'test_helper'

class TestCollection < Minitest::Test
  def test_from_response
    response = OpenStruct.new(body: [{ id: 1, name: 'test' }])
    collection = DevRuby::Collection.from_response(response: response,
                                                   type: DevRuby::Objects::BaseObject,
                                                   params: { page: 1, per_page: 1 })

    assert_equal DevRuby::Objects::BaseObject, collection.data.first.class
    assert_equal 1, collection.page
    assert_equal 1, collection.per_page
    assert_equal 2, collection.next_page
    assert_equal 0, collection.prev_page
    assert_equal 1, collection.data.count
    assert_equal 1, collection.data.first.id
    assert_equal 'test', collection.data.first.name
  end

  def test_from_response_with_empty_response
    response = OpenStruct.new(body: [])
    collection = DevRuby::Collection.from_response(response: response,
                                                   type: DevRuby::Objects::BaseObject,
                                                   params: { page: 1, per_page: 1 })

    assert_equal 0, collection.data.count
    assert_equal 1, collection.page
    assert_equal 1, collection.per_page
    assert_nil collection.next_page
    assert_equal 0, collection.prev_page
  end
end
