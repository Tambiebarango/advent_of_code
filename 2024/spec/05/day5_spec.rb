# frozen_string_literal: true

require_relative "../../05/day5"

describe Day5 do
  describe "#part_1" do
    context "when test" do
      it "returns correct result" do
        expect(described_class.new("test").part_1).to eq(143)
      end
    end

    context "when not test" do
      it "returns correct result?" do
        expect(described_class.new("actual").part_1).to eq(5268)
      end
    end
  end

  describe "#part_2" do
    context "when test" do
      specify { expect(described_class.new("test").part_2).to eq(123) }
    end

    context "when not test" do
      specify { expect(described_class.new("actual").part_2).to eq(5799) }
    end
  end
end
