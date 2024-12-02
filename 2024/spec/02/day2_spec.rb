# frozen_string_literal: true

# frozen_string_literal: true"

require_relative '../../02/day2'

describe Day2 do
  describe '#part_1' do
    context 'when env is test' do
      it 'returns correct result' do
        expect(described_class.new('test').part_1).to eq(2)
      end
    end

    context 'when env is not test' do
      it 'returns correct result?' do
        expect(described_class.new('actual').part_1).to eq(252) # ✅
      end
    end
  end

  describe '#part_2' do
    context 'when env is test' do
      it 'is accurate' do
        expect(described_class.new('test').part_2).to eq(4)
      end
    end

    context 'when env is not test' do
      it 'is accurate?' do
        expect(described_class.new('actual').part_2).to eq(324)
      end
    end
  end
end
