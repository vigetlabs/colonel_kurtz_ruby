require 'spec_helper'

RSpec.describe ColonelKurtz::Block do

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
  
  subject { described_class.new(data) }

  describe "#type" do
    it "returns the type" do
      expect(subject.type).to eq(:example_block)
    end
  end

  describe "#content" do
    it "returns the content" do
      expect(subject.content["html"]).to eq("<p>Example</p>")
    end
  end

  describe "#children" do
    it "returns the children blocks" do
      child = subject.children.first

      expect(child.type).to eq(:example_block)
    end
  end
  
  context "with Active Support" do
    require 'active_support/core_ext/hash/indifferent_access'

    describe "#content" do

      subject { described_class.new(data) }

      it "allows symbol key access" do
        expect(subject.content[:html]).to eq("<p>Example</p>")
      end
    end
  end
end
