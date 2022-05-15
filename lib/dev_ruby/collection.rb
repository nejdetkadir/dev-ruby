# frozen_string_literal: true

module DevRuby
  class Collection
    attr_reader :page, :per_page, :next_page, :prev_page, :data

    def self.from_response(response:, type:, params:)
      new(data: response.body.map { |attrs| type.new(attrs) },
          page: params[:page],
          per_page: params[:per_page])
    end

    def initialize(data:, page:, per_page:)
      @data = data
      @page = page
      @per_page = per_page
      @next_page = data.count.positive? ? (page + 1) : nil
      @prev_page = page.positive? ? (page - 1) : nil
    end
  end
end
