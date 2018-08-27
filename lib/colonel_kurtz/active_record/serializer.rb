module ColonelKurtz
  module ActiveRecord
    class Serializer
      def self.load(value)
        case value
        when String
          value
        when NilClass
          ''
        when Hash, Array
          value.to_json
        else
          raise_mismatch(value)
        end
      end

      def self.dump(value)
        case value
        when String
          JSON.parse(value)
        when NilClass
          []
        when Hash, Array
          value
        else
          raise_mismatch(value)
        end
      end

      def self.raise_mismatch(obj)
        raise(
          ::ActiveRecord::SerializationTypeMismatch,
          %(Attribute was supposed to be a ColonelKurtz block,
          but was a #{obj.class}. -- #{obj.inspect})
        )
      end
    end
  end
end
