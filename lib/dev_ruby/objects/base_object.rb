# frozen_string_literal: true

require 'ostruct'

module DevRuby
  module Objects
    class BaseObject < OpenStruct
      def initialize(attributes)
        super to_ostruct(attributes)
      end

      def to_ostruct(obj)
        case obj
        when Hash
          OpenStruct.new(obj.transform_values { |val| to_ostruct(val) })
        when Array
          obj.map { |o| to_ostruct(o) }
        else # Assumed to be a primitive value
          obj
        end
      end
    end
  end
end
