# Ruby wrapper for Colonel Kurtz data
#
# Contents of `data` hash
#
#   type:
#     block type
#     string, lower-cased and dashed, e.g. "hero-photo"
#
#   content:
#     block content
#     hash
#
#   blocks:
#     block children
#     array of `data` hashes
#

module ColonelKurtz
  class Block

    def initialize(data)
      @data = Data.new(data).to_hash
    end

    def type
      @type ||= Type.new(data.fetch("type")).to_sym
    end

    def content
      @content ||= data.fetch("content", {})
    end

    def children
      @children ||= blocks.map{ |data| Block.new(data) }
    end


    private

    attr_reader :data

    def blocks
      data.fetch("blocks", [])
    end
  end
end
