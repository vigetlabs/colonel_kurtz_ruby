module ColonelKurtz
  class Block


    private

    class Data

      attr_reader :data

      def initialize(data)
        @data = data
      end

      def to_hash
        defined?(HashWithIndifferentAccess) ? with_indifferent_access(data) : data
      end


      private

      def with_indifferent_access(hash)
        HashWithIndifferentAccess.new(hash)
      end
    end
  end
end
