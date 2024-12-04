# frozen_string_literal: true

require_relative "../../04/day4"

describe Day4 do
  describe "#part_1" do
    context "when test" do
      it "returns correct result" do
        expect(described_class.new("test").part_1).to eq(18)
      end
    end

    context "when actual" do
      it "returns correct result?" do
        pp described_class.new("actual").part_1
      end
    end
  end

  describe "#part_2" do
    context "when test" do
      it "returns correct rsult" do
        expect(described_class.new("test").part_2).to eq(9)
      end
    end

    context "when not test" do
      it "returns correct result" do
        expect(described_class.new("actual").part_2).to eq(1982)
      end
    end
  end
end
