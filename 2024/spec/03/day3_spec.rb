# frozen_string_literal: true

require_relative "../../03/day3"

describe Day3 do
  describe "#part_1" do
    context "when env is test" do
      it "returns the correct value" do
        expect(described_class.new("test").part_1).to eq(161)
      end
    end

    context "when env is not test" do
      it "returns the correct value?" do
        expect(described_class.new("actual").part_1).to eq(184576302) # ✅
      end
    end
  end

  describe "#part_2" do
    context "when env is test" do
      it "returns the correct value" do
        expect(described_class.new("test").part_2).to eq(48)
      end
    end

    context "when env is not test" do
      it "returns the correct value?" do
        expect(described_class.new("actual").part_2).to eq(118173507)
      end
    end
  end
end
