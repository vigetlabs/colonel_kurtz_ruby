require "json"

module ColonelKurtz
  module Model
    module Blockable

      def has_blocks(*fields)
        fields.each do |field|

          define_method "#{field}_blocks" do
            begin
              content = send(field)

              if content.is_a?(String)
                content = JSON.parse(content)
              end

              content.map { |data| ColonelKurtz::Block.new(data) }
            rescue
              [] # TODO error handling
            end
          end
        end
      end
    end
  end
end
