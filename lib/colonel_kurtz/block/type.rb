module ColonelKurtz
  class Block


    private

    class Type

      attr_reader :type

      def initialize(type)
        @type = type
      end

      def formatted_type
        type.gsub("-", "_").downcase
      end

      def to_sym
        formatted_type.to_sym
      end
    end
  end
end
