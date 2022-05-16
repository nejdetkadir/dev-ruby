# frozen_string_literal: true

require 'test_helper'

class TestArticlesResourceTest < Minitest::Test
  def test_published
    stub = stub_request(path: 'articles?page=1&per_page=20',
                        method: :get,
                        response: stub_response(fixture: 'articles/list', status: 200))
    client = DevRuby::Client.new(api_key: 'test', adapter: :test, stubs: stub)
    operation = client.articles.published

    published_articles = operation.success

    assert operation.success?
    assert_equal published_articles.data.count, 1
    assert_equal published_articles.data.first.id, 194_541
    assert_equal published_articles.data.first.class, DevRuby::Objects::Article
  end

  def test_create
    stub = stub_request(path: 'articles',
                        method: :post,
                        body: { article: { title: 'Test', body: 'Test' } },
                        response: stub_response(fixture: 'articles/_article', status: 201))
    client = DevRuby::Client.new(api_key: 'test', adapter: :test, stubs: stub)
    operation = client.articles.create(title: 'Test', body: 'Test')

    created_article = operation.success

    assert operation.success?
    assert_equal created_article.id, 194_541
    assert_equal created_article.class, DevRuby::Objects::Article
  end

  def test_latest_published
    stub = stub_request(path: 'articles/latest?page=1&per_page=20',
                        method: :get,
                        response: stub_response(fixture: 'articles/list', status: 200))
    client = DevRuby::Client.new(api_key: 'test', adapter: :test, stubs: stub)
    operation = client.articles.latest_published

    published_articles = operation.success

    assert operation.success?
    assert_equal published_articles.data.count, 1
    assert_equal published_articles.data.first.id, 194_541
    assert_equal published_articles.data.first.class, DevRuby::Objects::Article
  end

  def test_find
    stub = stub_request(path: 'articles/194541',
                        method: :put,
                        body: { article: { title: 'Test', body: 'Test' } },
                        response: stub_response(fixture: 'articles/_article', status: 200))
    client = DevRuby::Client.new(api_key: 'test', adapter: :test, stubs: stub)
    operation = client.articles.update(id: 194_541, title: 'Test', body: 'Test')

    created_article = operation.success

    assert operation.success?
    assert_equal created_article.id, 194_541
    assert_equal created_article.class, DevRuby::Objects::Article
  end

  def test_find_by_path
    stub = stub_request(path: 'articles/nejdetkadir/hello-world',
                        method: :get,
                        response: stub_response(fixture: 'articles/_article', status: 200))
    client = DevRuby::Client.new(api_key: 'test', adapter: :test, stubs: stub)
    operation = client.articles.find_by_path(username: 'nejdetkadir', slug: 'hello-world')

    created_article = operation.success

    assert operation.success?
    assert_equal created_article.id, 194_541
    assert_equal created_article.class, DevRuby::Objects::Article
  end

  def test_me
    stub = stub_request(path: 'articles/me',
                        method: :get,
                        response: stub_response(fixture: 'articles/list', status: 200))
    client = DevRuby::Client.new(api_key: 'test', adapter: :test, stubs: stub)
    operation = client.articles.me

    published_articles = operation.success

    assert operation.success?
    assert_equal published_articles.data.count, 1
    assert_equal published_articles.data.first.id, 194_541
    assert_equal published_articles.data.first.class, DevRuby::Objects::Article
  end

  def test_me_published
    stub = stub_request(path: 'articles/me/published',
                        method: :get,
                        response: stub_response(fixture: 'articles/list', status: 200))
    client = DevRuby::Client.new(api_key: 'test', adapter: :test, stubs: stub)
    operation = client.articles.me_published

    published_articles = operation.success

    assert operation.success?
    assert_equal published_articles.data.count, 1
    assert_equal published_articles.data.first.id, 194_541
    assert_equal published_articles.data.first.class, DevRuby::Objects::Article
  end

  def test_me_unpublished
    stub = stub_request(path: 'articles/me/unpublished',
                        method: :get,
                        response: stub_response(fixture: 'articles/list', status: 200))
    client = DevRuby::Client.new(api_key: 'test', adapter: :test, stubs: stub)
    operation = client.articles.me_unpublished

    published_articles = operation.success

    assert operation.success?
    assert_equal published_articles.data.count, 1
    assert_equal published_articles.data.first.id, 194_541
    assert_equal published_articles.data.first.class, DevRuby::Objects::Article
  end

  def test_me_all
    stub = stub_request(path: 'articles/me/all',
                        method: :get,
                        response: stub_response(fixture: 'articles/list', status: 200))
    client = DevRuby::Client.new(api_key: 'test', adapter: :test, stubs: stub)
    operation = client.articles.me_all

    published_articles = operation.success

    assert operation.success?
    assert_equal published_articles.data.count, 1
    assert_equal published_articles.data.first.id, 194_541
    assert_equal published_articles.data.first.class, DevRuby::Objects::Article
  end

  def test_videos
    stub = stub_request(path: 'videos',
                        method: :get,
                        response: stub_response(fixture: 'videos/list', status: 200))
    client = DevRuby::Client.new(api_key: 'test', adapter: :test, stubs: stub)
    operation = client.articles.videos

    published_articles = operation.success

    assert operation.success?
    assert_equal published_articles.data.count, 1
    assert_equal published_articles.data.first.id, 273_532
    assert_equal published_articles.data.first.class, DevRuby::Objects::VideoArticle
  end
end
