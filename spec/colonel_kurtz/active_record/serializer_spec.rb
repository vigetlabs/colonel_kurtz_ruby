require 'spec_helper'

RSpec.describe ColonelKurtz::ActiveRecord::Serializer do
  describe ".load" do
    context "when value is a String" do
      it "returns as a string" do
        result = described_class.load('test')
        expect(result).to eq 'test'
      end
    end

    context "when value is nil" do
      it "returns as an empty string" do
        result = described_class.load(nil)
        expect(result).to eq ''
      end
    end

    context "when value is a Hash or Array" do
      it "returns as a serialized json string" do
        hash_result = described_class.load(test: "value")
        expect(hash_result).to eq '{"test":"value"}'

        array_result = described_class.load(["value"])
        expect(array_result).to eq '["value"]'
      end
    end

    context "when value is unexpected" do
      require 'active_record/errors'

      it "raises a SerializationTypeMismatch" do
        expect { described_class.load(123) }.to raise_error(ActiveRecord::SerializationTypeMismatch)
      end
    end
  end

  describe ".dump" do
    context "when value is a String" do
      it "returns as a Hash" do
        result = described_class.dump('{"test":"value"}')
        expect(result).to eq Hash["test" => "value"]
      end
    end

    context "when value is nil" do
      it "returns as an empty Array" do
        result = described_class.dump(nil)
        expect(result).to eq []
      end
    end

    context "when value is a Hash or Array" do
      it "passes through" do
        hash = Hash["test" => "value"]
        hash_result = described_class.dump(hash)
        expect(hash_result).to eq hash

        array = ["value"]
        array_result = described_class.dump(array)
        expect(array_result).to eq array
      end
    end

    context "when value is unexpected" do
      require 'active_record/errors'

      it "raises a SerializationTypeMismatch" do
        expect { described_class.load(123) }.to raise_error(ActiveRecord::SerializationTypeMismatch)
      end
    end
  end
end
