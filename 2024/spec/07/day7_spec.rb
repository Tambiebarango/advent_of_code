# frozen_string_literal: true

require_relative "../../07/day7"

describe Day7 do
  describe "part_1" do
    context "when test" do
      specify { expect(described_class.new("test").part_1).to eq(3749) }
    end

    context "when actual" do
      specify { expect(described_class.new("actual").part_1).to eq(2664460013123) }
    end
  end

  describe "part_1" do
    context "when test" do
      specify { expect(described_class.new("test").part_2).to eq(11387) }
    end

    context "when actual" do
      specify { expect(described_class.new("actual").part_2).to eq(426214131924213) }
    end
  end
end
