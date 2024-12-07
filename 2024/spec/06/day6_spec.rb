# frozen_string_literal: true

require_relative "../../06/day6"

describe Day6 do
  describe "#part_1" do
    context "when test" do
      it "returns the correct result" do
        expect(described_class.new("test").part_1).to eq(41)
      end
    end

    context "when actual" do
      it "returns the correct result" do
        expect(described_class.new("actual").part_1).to eq(4778)
      end
    end
  end

  describe "#part_2" do
    context "when test" do
      it "returns the correct result" do
        expect(described_class.new("test").part_2).to eq(6)
      end
    end

    context "when actual" do
      it "returns the correct result" do
        expect(described_class.new("actual").part_2).to eq(1618)
      end
    end
  end
end
