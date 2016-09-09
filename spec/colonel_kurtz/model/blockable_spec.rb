require "spec_helper"

require "json"

class BlockableExample
  extend ColonelKurtz::Model::Blockable

  has_blocks :content

  attr_reader :content

  def initialize(content)
    @content = content
  end
end

RSpec.describe BlockableExample do

  let(:data) do
    {
      "type"    => "example-block",
      "content" => { "html" => "<p>Example</p>" },
      "blocks"  => [
        {
          "type"    => "example-block",
          "content" => { "html" => "<p>Text</p>" },
          "blocks"  => []
        }
      ]
    }
  end

  describe "with a JSON string" do
    subject { described_class.new(JSON.generate(data)) }

    describe ".has_blocks" do
      it "creates 'field_blocks' accessor" do
        should respond_to(:content_blocks)
      end

      it "returns an array" do
        expect(subject.content_blocks).to be_a(Array)
      end

      it "returns an array of Blocks" do
        block = subject.content_blocks.first

        expect(block).to be_a(ColonelKurtz::Block)
      end
    end

    describe "with a parsed data structure" do
      subject { described_class.new(data) }

      it "returns an array" do
        expect(subject.content_blocks).to be_a(Array)
      end

      it "returns an array of Blocks" do
        block = subject.content_blocks.first

        expect(block).to be_a(ColonelKurtz::Block)
      end
    end

    context "with bad Colonel Kurtz data" do
      subject { described_class.new("jank") }

      it "returns and empty array" do
        expect(subject.content_blocks).to eq([])
      end
    end
  end
end
